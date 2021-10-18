from kivy.app import App
from kivy.uix.widget import Widget
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.gridlayout import GridLayout
from kivy.lang import *
from kivy.core.window import Window
from kivy.uix.filechooser import FileChooserListView
from kivy.uix.treeview import TreeView,TreeViewLabel,TreeViewNode
from kivy.uix.togglebutton import ToggleButton
from kivy.uix.button import Button
from kivy.uix.codeinput import CodeInput
from kivy.uix.modalview import ModalView
from kivy.uix.textinput import TextInput
from kivy.uix.screenmanager import Screen,ScreenManager

from kivy.clock import Clock, mainthread
import json

import sys
import os
from os.path import join
import subprocess
import shutil
from pythoncall_builder import PythonCallBuilder
from build_files.pack_files import pack_all,remove_cache_file
from threading import Thread

from pygments.lexers.objective import ObjectiveCLexer
from pygments.lexers import CythonLexer

from filecmp import cmp,cmpfiles
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

Window.size = (1920, 1080)
Window.left = 0

Builder.load_string("""
<MainWindow>:
    orientation: 'vertical'
    BoxLayout:
        size_hint_y: None
        height: 36
        Button:
            text: "Swift/OBJ-C Wrapper Generator"
            on_release:
                screens.current = "screen0"
        Button:
            text: "Py Files Compiler"
            on_release:
                screens.current = "screen1"
    ScreenManager:
        id: screens
        Screen:
            name: "screen0"
            BoxLayout:
                orientation: 'vertical'
                BoxLayout:
                    id: TopMenu
                    size_hint_y: 0.4
                    BoxLayout:
                        orientation: 'vertical'
                        Label:
                            text: "Imported py's"
                            size_hint_y:None
                            height: 24
                        ScrollView:
                            GridLayout:
                                cols: 1
                                #default_row_height: 48
                                id: imports
                                size_hint_y: None
                                height: self.minimum_height
                    BoxLayout:
                        orientation: 'vertical'
                        Label:
                            text: "Builds"
                            size_hint_y:None
                            height: 24
                        ScrollView:
                            GridLayout:
                                id: builds
                                cols: 1
                                size_hint_y: None
                                height: self.minimum_height
                    BoxLayout:
                        orientation: 'vertical'
                        Label:
                            text: "Commands"
                            size_hint_y:None
                            height: 24
                        Button:
                            id: command0
                            text: "-"
                            
                        Button:
                            id: command1
                            text: "-"
                            
                        Button:
                            id: command2
                            text: "-"
                            on_press:
                                print("Building % Compiling All")
                    
                CodeViews:
                    id: codeviews
        Screen:
            name: "screen1"

""")

class MainWindow(BoxLayout):
    pass

class FileItem():
    type: str
    name: str
    
    def __init__(self,name,type):
        self.type = type
        self.name = name


Builder.load_string("""
<FileTreeViewer>:

""")

class FileTreeViewer(TreeView):
    def __init__(self, **kwargs):
        super(FileTreeViewer,self).__init__(**kwargs)


Builder.load_string("""
<CodeView>:
    orientation: 'vertical'
    Label:
        id:label
        size_hint_y:None
        height: 24
    CodeInput:
        id:code
""")

class CodeView(BoxLayout):
    def __init__(self, **kwargs):
        super(CodeView,self).__init__(**kwargs)

Builder.load_string("""
<CodeViews>:
    
    CodeView:
        id: view1
    CodeView:
        id: view2
    CodeView:
        id: view3

""")
class CodeViews(BoxLayout):
    
    def __init__(self, **kwargs):
        super(CodeViews,self).__init__(**kwargs)


    
kivy_folder = "/Volumes/WorkSSD/kivy-ios-11.04.20_copy/"
toolchain = join(kivy_folder,"toolchain.py")
root_path = os.path.dirname(sys.argv[0])

class EventHandler(FileSystemEventHandler):
    app = None
    def __init__(self,app, **kwargs):
        super(EventHandler,self).__init__(**kwargs)
        self.app = app

    def on_any_event(self, event):
        app:KivySwiftLink = self.app
        #event.is
        file_str = event.src_path
        filetype = file_str.split('.')
        if filetype[-1] == 'py':
            #src = path + event.src_path
            
            print (event.src_path)
            app.build_wdog_event(event.src_path)







class KivySwiftLink(App):
    main: MainWindow
    imports: GridLayout
    group = "builders"
    selected_py: ToggleButton
    calltitle: str = ""
    mode = -1
    def __init__(self, **kwargs):
        super(KivySwiftLink,self).__init__(**kwargs)
        self.wdog_thread()
    
    def build_selected(self,py_sel):
        p_build = PythonCallBuilder()
        root_path = os.path.dirname(sys.argv[0])
        
        if py_sel.type == "imports":
            cy_string,objc_h_script = p_build.build_py_files(os.path.join(root_path,"imported_pys",py_sel.text))
            calltitle = p_build.get_calltitle()
            self.calltitle = calltitle
            self.view2.text = cy_string
            self.view2.scroll_y = 0
            self.view3.text = objc_h_script
            self.view3.scroll_y = 0
        else:
            calltitle = py_sel.title
            self.calltitle = calltitle

        
        pack_all("master.zip",calltitle)

    def build_wdog_event(self,filename):
        p_build = PythonCallBuilder()
        
        p_build.build_py_files(filename)
        calltitle = p_build.get_calltitle()

        pack_all("master.zip",calltitle)
        thread = Thread(target=self.compiler,args=[calltitle])
        thread.start()

    def wdog_thread(self):
        event_handler = EventHandler(self)
        observer = Observer()
        observer.schedule(event_handler, join(root_path,"imported_pys"), recursive=True,)
        observer.start()

    def compile_selected(self,btn):
        self.build_log.text = "Compiling:\n"
        #self.build_log.text.__add__("Compiling:\n")
        self.build_popup.open()
        thread = Thread(target=self.compiler,args=[btn.title])
        thread.start()
     
    def show_imports(self):
        imports:GridLayout = self.imports
        imports.clear_widgets()
        for item in os.listdir(join(root_path,"imported_pys")):
            t = ToggleButton(
                text= item,
                group=self.group,
                size_hint_y=None,
                height=48
            )
            t.type = "imports"
            t.bind(on_press=self.btn_action)
            # with open(join(root_path,"imported_pys",item)) as f:
            t.title = item
            imports.add_widget(t)
    
    def show_builds(self,*args):
        builds:GridLayout = self.builds
        builds.clear_widgets()
        
        for item in os.listdir(join(root_path,"builds")):
            print(item)
            try:
                if os.path.isdir(join(root_path,"builds",item)):
                    if os.path.exists(join(root_path,"builds",item,"module.ini")):
                        with open(join(root_path,"builds",item,"module.ini")) as f:
                            key,module = json.loads(f.read())
                            t = ToggleButton(
                                group=self.group,
                                size_hint_y=None,
                                height=48
                            )
                            t.type = "builds"
                            if module['type'] != "custom":
                                t.title = module['title']
                                t.text= module["title"]
                            else:
                                t.title = module['classname']
                                t.text= module["classname"]
                            t.bind(on_press=self.btn_action)
                            builds.add_widget(t)
            except Exception as E:
                print(E)
    #     s = os.path.join(src, item)
    #     d = os.path.join(dst, item)
    #     if os.path.isdir(s):
    #         shutil.copytree(s, d, False, None)

    def btn_action(self,btn:ToggleButton):
        if btn.state is 'normal':
            btn.state = 'down'
            print(btn.text)
        path = join(root_path,"imported_pys",btn.text)
        #if btn.state is 'down':
        self.selected_py = btn
        if btn.type == "imports":
            self.command0.text = "Build Selected"
            self.command1.text = "Build All"
            self.mode = 0
            with open(path, 'r') as pyfile:
                print(path)
                self.view1.text = pyfile.read()
                self.view2.text = ""
                self.view3.text = ""
                self.view1.scroll_y = 0
        else:
            self.command0.text = "Compile Selected"
            self.command1.text = "Compile All"
            self.mode = 1

    def compiler(self,calltitle):
        #build_file = join(root_path,"builds",calltitle,"module_name.json")
        build_file = join(root_path,"builds",calltitle,"kivy_recipe.py")

        target_path = join(kivy_folder,"recipes",calltitle)
        if not os.path.exists( target_path ):
            os.makedirs(target_path)
        recipe_path = join(target_path,"__init__.py")
        if os.path.exists( recipe_path ):
            print("__init__.py Exists")
            if not cmp(build_file,recipe_path):
                print("Updating __init__.py")
                shutil.copy(build_file,recipe_path)
        else:
            shutil.copy(build_file,recipe_path)
        try:
            remove_cache_file( join(kivy_folder,".cache",calltitle+"-master.zip") )
        except:
            pass
        print(calltitle)
        command = " ".join(['python3.7',toolchain, "clean", calltitle])  # the shell command
        self.execute(command)
        command = " ".join(['python3.7',toolchain, "build", calltitle])  # the shell command
        self.execute(command)
        command = " ".join(['python3.7',toolchain, "clean", calltitle])  # the shell command
        self.execute(command)
        try:
            remove_cache_file(kivy_folder+".cache/"+calltitle+"-master.zip")
        except:
            pass


    def execute(self,command):
        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        
        # Poll process for new output until finished
        while True:
            nextline = process.stdout.readline()
            if nextline == b'' and process.poll() is not None:
                break
            #sys.stdout.write(nextline.decode('utf-8'))
            line = nextline.decode('utf-8')
            sys.stdout.flush()
            self.update_log(line)

    @mainthread
    def update_log(self,text:str):
        
        self.build_log.text += text
        #self.build_log.insert_text(text)
    def command_actions(self,btn:Button):
        print("command_actions",btn.text)
        if self.mode == 1:
            if btn.idx == 0:
                self.compile_selected(self.selected_py)
            elif btn.idx == 1:
                pass
            elif btn.idx == 2:
                pass
        else:
            if btn.idx == 0:
                self.build_selected(self.selected_py)





    def build(self):
        self.main = MainWindow()
        ids = self.main.ids
        print(self.main.ids)
        self.codeviews: CodeViews = self.main.ids.codeviews
        print(self.codeviews.ids)
        self.imports = ids.imports
        self.builds = ids.builds
        self.sm:ScreenManager = ids.screens
        self.command0: Button = ids.command0
        self.command0.bind(on_press=self.command_actions)
        self.command0.idx = 0
        self.command1: Button = ids.command1
        self.command1.bind(on_press=self.command_actions)
        self.command1.idx = 1
        self.command2: Button = ids.command2
        self.command2.bind(on_press=self.command_actions)
        self.command2.idx = 2

        codes = self.codeviews
        codes.ids.view1.ids.label.text = "Python Code"
        codes.ids.view2.ids.label.text = "Cython .pyx"
        codes.ids.view3.ids.label.text = "OBJ-C .h"
        self.view1: CodeInput = codes.ids.view1.ids.code
        self.view2: CodeInput = codes.ids.view2.ids.code
        self.view2.lexer = CythonLexer()
        self.view3: CodeInput = codes.ids.view3.ids.code
        self.view3.lexer = ObjectiveCLexer()
        self.show_imports()
        self.show_builds(None)
        self.build_log = TextInput(
        )
        self.build_log.background_color = [0, 0, 0, 1]
        self.build_log.foreground_color = [0, 1, 0, 1]
        self.build_log.readonly = True
        self.build_popup = ModalView()
        self.build_popup.size_hint = (0.8,0.8)
        self.build_popup.add_widget(self.build_log)

        return self.main

if __name__ == '__main__':
    KivySwiftLink().run()