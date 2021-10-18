from genericpath import exists
from logging import root
from re import search
from time import localtime
from typing import List
from kivy.app import App
from kivy.core import text
from kivy.core import image
from kivy.core.image import Image as CoreImage
from kivy.storage import jsonstore
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
from kivy.storage.dictstore import DictStore
from kivy.storage.jsonstore import JsonStore
from kivy.config import ConfigParser
from kivy.uix.settings import Settings
from kivy.uix.settings import SettingsWithTabbedPanel
from kivy.properties import ObjectProperty, StringProperty, BooleanProperty, NumericProperty
from kivy.clock import Clock, mainthread
from kivy.uix.popup import Popup
import json
import applescript
import sys
import os
import re
from os.path import getmtime, isdir, join,dirname
import subprocess
import shutil
from PythonSwiftLink.pythoncall_builder import PythonCallBuilder
from PythonSwiftLink.build_files.pack_files import pack_all,remove_cache_file
from threading import Thread
from tinydb import TinyDB, Query
from tinydb.operations import set as db_set
from datetime import datetime

from pygments.lexers.objective import ObjectiveCLexer
from pygments.lexers import CythonLexer

from filecmp import cmp,cmpfiles
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler


from pbxproj import XcodeProject,PBXKey
from pbxproj.pbxextensions.ProjectFiles import FileOptions


Window.size = (1920, 1080)
Window.left = 0

dir_path = dirname(__file__)

class BuildDB:
    db: TinyDB
    user: Query
    root_path: str

    def __init__(self,root_path) -> None:
        self.root_path = root_path
        db_path = join(root_path,"build_db.json")
        if not exists(db_path):
            with open(db_path, "w"):
                pass
        self.db = TinyDB(db_path, indent=4)
        self.user = Query()

    def wrap_exist(self, py_file) -> bool:
        db = self.db
        user = self.user
        try:
            py_date = db.search(user.py_file == py_file)[0]
        except:
            print(py_file,"wrap - dont exist")
            return False
        return True
    
    def update_key(self, py_file, key, value):
        db = self.db
        user = self.user
        db.update(db_set(key, value), user.py_file == py_file)
    
    def create_build(self,py_file: str, class_title: str):
        py_path = join(self.root_path,"wrapper_sources",py_file)
        py_date = getmtime(py_path)
        build_info = {
            "id": py_file,
            "class_title": class_title,
            "build_title": class_title.lower(),
            "py_file": py_file,
            "py_date": py_date,
            "build_date": py_date,
            "is_build": 0,
            "compile_date": 0,
            "compiled": 0
        }
        print("creating build", build_info)
        self.db.insert(build_info)
    
    def update_py_date(self,py_file):
        py_path = join(self.root_path,"wrapper_sources",py_file)
        py_date = getmtime(py_path)
        db = self.db
        user = self.user
        #result = db.search(user.py_file == py_file)
        #if len(result) != 0:
        db.update(db_set('py_date', py_date), user.py_file == py_file)
    
    def update_build_date(self, py_file):

        db = self.db
        user = self.user
        try:
            py_date = db.search(user.py_file == py_file)[0]["py_date"]
        except:
            print(py_file,"dont exist")
            return
        db.update(db_set('py_date', py_date), user.py_file == py_file)

    def compare_build_date(self, py_file):
        db = self.db
        user = self.user
        try:
            result = db.search(user.py_file == py_file)[0]
        except:
            print(py_file,"dont exist")
            return
        
        py_date = result["py_date"]
        build_date = result["build_date"]
        if build_date < py_date:
            print("Wrapper build needs update")
    
    def compare_compile_date(self, py_file):
        db = self.db
        user = self.user
        try:
            result = db.search(user.py_file == py_file)[0]
        except:
            print("dont exist")
            return
        
        py_date = result["py_date"]
        compile_date = result["compile_date"]
        if compile_date < py_date:
            print("compile is out of date")
    
    def get_item(self, py_file) -> dict:
        db = self.db
        user = self.user
        try:
            return db.search(user.py_file == py_file)[0]
        except:
            print("dont exist")
            return None

class TitleNode(BoxLayout,TreeViewNode):
    pass

class TitleNode2(BoxLayout,TreeViewNode):
    pass

no_tex = CoreImage(join(dir_path,"icons","no.png")).texture
yes_tex = CoreImage(join(dir_path,"icons","yes.png")).texture
sign_tex = CoreImage(join(dir_path,"icons","sign.png")).texture

class ProjectFileNode(BoxLayout,TreeViewNode):
    text = StringProperty("")
    is_build = NumericProperty(3)
    compiled = NumericProperty(3)
    build_tex = ObjectProperty(None)
    compiled_tex = ObjectProperty(None)
    project_selected = NumericProperty(0)
    alpha = NumericProperty(0)
    path: str = None
    def __init__(self, **kw):
        #self.no_tex = CoreImage(join(dir_path,"icons","no.png")).texture
        self.build_tex = CoreImage(join(dir_path,"icons","yes.png")).texture
        #self.sign_tex = CoreImage(join(dir_path,"icons","sign.png")).texture
        text = kw.pop("text")
        self.path = kw.pop("path")
        #is_build = kw.pop("is_build")
        #compiled = kw.pop("compiled")
        super(ProjectFileNode, self).__init__(**kw)
        self.text = text
        #self.is_build = is_build
        #self.compiled = compiled
        #self.upstte(compiled)
        
    def on_project_selected(self,wid,value):
        print(self.text,"alpha",value)
        #pass
        self.alpha = value

    def update_state(self,state):

        self.alpha = state

class WrapperFileNode(BoxLayout,TreeViewNode):
    text = StringProperty("")
    is_build = NumericProperty(3)
    compiled = NumericProperty(3)
    build_tex = ObjectProperty(None)
    compiled_tex = ObjectProperty(None)
    def __init__(self, **kw):
        self.no_tex = CoreImage(join(dir_path,"icons","no.png")).texture
        self.yes_tex = CoreImage(join(dir_path,"icons","yes.png")).texture
        self.sign_tex = CoreImage(join(dir_path,"icons","sign.png")).texture
        text = kw.pop("text")
        is_build = kw.pop("is_build")
        compiled = kw.pop("compiled")
        super(WrapperFileNode, self).__init__(**kw)
        self.text = text
        self.is_build = is_build
        #self.compiled = compiled
        self.update_compile(compiled)
        

    def update_compile(self,state):
        print("updating compile")
        self.compiled = state
        if state == 1:
            self.compiled_tex = self.yes_tex
        elif state == 0:
            self.compiled_tex = self.no_tex
        else:
            self.compiled_tex = self.sign_tex
    
    def on_is_build(self,wid,state):
        #img = self.ids.build_label
        print(wid.text,"on_is_build",state)
        if state == 1:
            self.build_tex = yes_tex
        elif state == 0:
            self.build_tex = no_tex
        else:
            self.build_tex = sign_tex

    def on_ís_compiled(self,wid,state):
        print(wid.text,"on_compiled",state)
        if state == 1:
            self.compiled_tex = yes_tex
        elif state == 0:
            self.compiled_tex = no_tex
        else:
            self.compiled_tex = sign_tex

class MainMenu(Screen):
    wrapper_view = ObjectProperty(None)
    build_log = ObjectProperty(None)
    pass

class StringInput(TextInput):

    pat = re.compile('[^a-z]')
    def insert_text(self, substring, from_undo=False):
        pat = self.pat
        s = '.'.join([re.sub(pat, '', s) for s in substring.split('.', 1)])
        return super(StringInput, self).insert_text(s, from_undo=from_undo)

class FileLoader(BoxLayout):
    popup: ObjectProperty(None)
    pass
    def is_dir(self, directory, filename):
        return isdir(join(directory, filename))

class ProjectsMenu(Screen):
    project_view = ObjectProperty(None)
    build_log = ObjectProperty(None)
    pass

    def show_load(self):
        app = App.get_running_app()
        
        self._popup = Popup(title="Select Python Source Folder",
                            size_hint=(0.6, 0.8))
        content = FileLoader()
        content.popup=self._popup
        self._popup.content=content
        self._popup.open()

Builder.load_file(join(dir_path,"menus.kv"))

Builder.load_string("""
<ProjectBuilder>:
    orientation: 'vertical'
    # BoxLayout:
    #     size_hint_y: None
    #     height: 48
    #     Button:
    #         text: "step0"
    #         on_release:
    #             project_screen.current = "step0"
    #     Button:
    #         text: "step1"
    #         on_release:
    #             project_screen.current = "step1"
    #     Button:
    #         text: "step2"
    #         on_release:
    #             project_screen.current = "step2"
    #     Button:
    #         text: "step3"
    #         on_release:
    #             project_screen.current = "step3"
    #     Button:
    #         text: "step4"
    #         on_release:
    #             project_screen.current = "step4"
    #     Button:
    #         text: "step5"
    #         on_release:
    #             project_screen.current = "step5"
    #     Button:
    #         text: "step6"
    #         on_release:
    #             project_screen.current = "step6"
        
            
    ScreenManager:
        id: project_screen
        Screen:
            name: "step0"
            FloatLayout:
                BoxLayout:
                    pos_hint: {'center_x': 0.5 , 'center_y': 0.5}
                    size_hint: 0.4, 0.3
                    Label:
                        text: "Add standard files"
                    Button:
                        on_release:
                            app.update_classes_group()

                Button:
                    size_hint: None,None
                    pos_hint: {'right': 1, 'y': 0}
            
        Screen:
            name: "step1"
        Screen:
            name: "step2"
        Screen:
            name: "step3"
        Screen:
            name: "step4"
        Screen:
            name: "step5"
        Screen:
            name: "step6"
""")

class ProjectBuilder(BoxLayout):
    pass

Builder.load_string("""
<MainWindow>:
    orientation: 'vertical'
    BoxLayout:
        size_hint_y: None
        height: 36
        Button:
            text: "Projects"
            on_release:
                screens.current = "project_menu"
        Button:
            text: "Swift/OBJ-C Wrapper Generator"
            on_release:
                screens.current = "wrapper_menu"
        Button:
            text: "Settings"
            on_release:
                screens.current = "screen1"
        Button:
            text: "Settings2"
            on_release:
                screens.current = "screen2"
    ScreenManager:
        id: screens

        ProjectsMenu:
            id: project_menu
            name: "project_menu"

        MainMenu:
            id: main_menu
            name: "wrapper_menu"
        
        Screen:
            name: "screen1"
            ProjectBuilder:

        Screen:
            name: "screen2"
            BoxLayout:
                id: settings_box

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
Builder.load_string("""
<CodeViewPy>:
    orientation: 'vertical'
    BoxLayout:
        size_hint_y:None
        height: 24
        Label:
            id:label
        Button:
        
            text: "Save"
            size_hint_x: None
            width: 48
    CodeInput:
        id:code
""")
class CodeView(BoxLayout):
    def __init__(self, **kwargs):
        super(CodeView,self).__init__(**kwargs)

class CodeViewPy(BoxLayout):
    def __init__(self, **kwargs):
        super(CodeViewPy,self).__init__(**kwargs)

Builder.load_string("""
<CodeViews>:
    
    CodeViewPy:
        id: view1
    CodeView:
        id: view2
    CodeView:
        id: view3

""")
class CodeViews(BoxLayout):
    
    def __init__(self, **kwargs):
        super(CodeViews,self).__init__(**kwargs)

print("file path",dirname(__file__))

#toolchain = join(kivy_folder,"toolchain.py")
toolchain = "toolchain"
root_path = os.path.dirname(sys.argv[0])

class EventHandler(FileSystemEventHandler):
    app = None
    def __init__(self,app, **kwargs):
        super(EventHandler,self).__init__(**kwargs)
        self.app = app
        self.new_file_created = False
        
        
    def on_created(self, event):
        self.app.show_imports()
        self.new_file_created = True

    def on_modified(self, event):
        py_string = None
        new = False
        if isdir(event.src_path):
            return
        if self.new_file_created:
            new = self.new_file_created
            if new:
                self.new_file_created = False
            with open(event.src_path,"r") as f:
                
                py_string = f.read()
            
        if py_string:
            if py_string == "":
                return

        app:KivySwiftLink = self.app
        file_str = os.path.basename(event.src_path)
        #event.is
        #file_str = event.src_path
        filetype = file_str.split('.')
        if filetype[-1] == 'py':
            #src = path + event.src_path
            
            #print (event.src_path)
            app.build_wdog_event(file_str,new)





class TreeGroup(TreeViewLabel):
    pass


class KivySwiftLink(App):
    main: MainWindow
    imports: GridLayout
    group = "builders"
    selected_py: ToggleButton
    calltitle: str = ""
    mode = -1
    root_path: str
    kivy_folder:str
    kivy_recipes: str

    selected_project_node: ProjectFileNode

    def __init__(self,root_path, **kwargs):
        super(KivySwiftLink,self).__init__(**kwargs)
        self.project = None
        self.root_path = root_path
        self.selected_project_node = None
        self.wrapper_files = None
        self.wdog_thread()
        self.app_dir = join(root_path,"PythonSwiftLink")
        db_path = join(root_path,"build_db.json")
        print("root path:",root_path)
        self.selected_py = None
        self.wrappers: List[WrapperFileNode] = []
        self.projects: List[ProjectFileNode] = []
        # config_str = ""
        # with open(join(self.app_dir,"config.json"),"r") as f:
        #     config_str = f.read()
        # config = json.loads(config_str)
        # self.kivy_folder = config['kivy_ios_folder']
        self.kivy_folder = root_path
        #self.kivy_recipes = config['kivy_ios_recipes']
        self.kivy_recipes = join(root_path,"venv/lib/python3.8/site-packages/kivy_ios/recipes")
        # global _json
        # global _json_store
        # _json_store = JsonStore(join(root_path,"build_config.json"))
        # _json = {**_json_store}
        
        self.db = BuildDB(root_path)
        self.wrap_dict = {}

        # if "build_info" in _json:
        #     self.build_info = _json.get("build_info")
        # else:
        #     self.build_info = {}
        #     _json_store["build_info"] = self.build_info
        # self.test_dict = {}

        # if "builds" not in _json_store["build_info"]:
        #     _json_store["build_info"]["builds"] = {}
        # if "project_target" in _json_store["build_info"]:

        #     self.project_target = _json_store["build_info"]["project_target"]
        # else:
        #     self.project_target = None
        self.project_target = None
        # self.test_dict["test2"] = {}
        # _json_store["test2"] = self.test_dict
        #self.build_info["root_path"] = root_path
        #self.storage["build_info"] = self.build_info
        #print(self.storage.__dict__)
    #"/Users/macdaw/kivyios_swift/venv/lib/python3.8/site-packages/kivy_ios/recipes"
    def build_all_updates(self):
        for wrap in self.wrappers:
            if wrap.is_build != 1:
                self.build_selected(wrap)
    
    def compile_all_updates(self):
        self.build_log.text = "Compiling:\n"
        
        #self.build_log.text.__add__("Compiling:\n")
        #self.build_popup.open()
        self.sub_view.current = "log_screen"
        thread = Thread(target=self.compile_all_thread,args=[])
        thread.start()
    
    def compile_all_thread(self):
        wrappers_count = len(self.wrappers)
        new_compiled_wraps = []
        for i, wrap in enumerate(self.wrappers):
            if self.db.wrap_exist(wrap.title):
                title = self.db.get_item(wrap.title)["class_title"]
            self.update_log("\n\%sn" % wrap.text)
            if wrap.compiled != 1 and wrap.is_build == 1:
                self.compiler(wrap,title)
                new_compiled_wraps.append(title)
            
        self.update_frameworks(new_compiled_wraps)
            #self.update_log(self.calltitle)
    


    def build_selected(self,py_sel: WrapperFileNode):
        if py_sel:
            p_build = PythonCallBuilder(self.app_dir, self.root_path)
            root_path = os.path.dirname(sys.argv[0])
            print("build_selected",py_sel)
            print(py_sel.text,py_sel.is_build)
            py_file = os.path.join(self.app_dir,"imported_pys",py_sel.text)
            #print(os.path.join(self.app_dir,"imported_pys",py_sel.text))
            if py_sel.type == "imports":
                #cy_string,objc_h_script = p_build.build_py_files(os.path.join(self.app_dir,"imported_pys",py_sel.text))
                cy_string,objc_h_script = p_build.build_py_files(os.path.join(self.root_path,"wrapper_sources",py_sel.text))
                calltitle = p_build.get_calltitle()
                self.calltitle = calltitle
                # self.view2.text = cy_string
                # self.view2.scroll_y = 0
                # self.view3.text = objc_h_script
                # self.view3.scroll_y = 0
            else:
                calltitle = py_sel.title
                self.calltitle = calltitle
            
            #shutil.copy(py_file, )
            pack_all(self.root_path,self.app_dir,"master.zip",calltitle)
            try:
                #file_time = getmtime(join(self.app_dir,"cython_headers","_%s.h" % calltitle))
                file_time = getmtime(join(self.root_path,"wrapper_headers","_%s.h" % calltitle))
            except:
                file_time = 0
            #self.update_header_group()
            
            #self.show_builds()
            #print("show_builds")
            exist = self.db.wrap_exist(py_sel.text)
            
            if not exist:
                self.db.create_build(py_sel.text,calltitle)
                py_sel.is_build = 1
            else:
                self.db.update_key(py_sel.text, "is_build", 1)
                py_date = self.db.get_item(py_sel.text)["py_date"]
                self.db.update_key(py_sel.text, "build_date", py_date)
                py_sel.is_build = 1
        #
    # def set_project_folder(self,paths):
    #     d = _json_store["build_info"]
    #     try:
    #         print(paths)
    #         path = paths[0]
    #         print(path,isdir(path))
    #         if isdir(path):
    #             d["project_target"] = path
    #             self.project_target = path
    #         _json_store["build_info"] = d
    #     except:
    #         print("Setproject error")

    #remember
    # def update_build_dict(self,file):
    #     d = _json_store["build_info"]
    #     builds = d["builds"]
    #     if file in builds:
    #         pass
    #     else:
    #         header = "_%s.h" % file
    #         hpath = join(self.app_dir,"cython_headers",header)
    #         builds[file] = {
    #             "header": header,
    #             "path": hpath,
    #             "source_time": getmtime(hpath),
    #             "build_time": getmtime(hpath)
    #         }
    #     print(d)
    #     _json_store["build_info"] = d
    def update_frameworks(self,frame_names: List[str]):
        self.load_xcode_project()
        project = self.project
        if project:
            if self.project_target:
                for name in frame_names:
                    key_word = f"lib{name}.a"
                    # target = self.project_target
                    # target_name = os.path.basename(target)[:-4]
                    # print("target_name: ",target_name)
                    # path = "%s/%s.xcodeproj/project.pbxproj" % (target, target_name)
                    
                    frameworks = project.get_or_create_group("Frameworks")
                    framework_list = set([child._get_comment() for child in frameworks.children])
                    if key_word not in framework_list:
                        project.add_file(join(self.root_path,"dist","lib",key_word),frameworks)
                #if start == end:
                project.backup()
                project.save()

    def update_classes_group(self):
        self.load_xcode_project()
        project = self.project
        project_updated = True
        
        if not project:
            return
        if self.project_target and self.project:
            project.remove_framework_search_paths(["/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.4.sdk/System/Library/Frameworks"])
            project.remove_library_search_paths(["/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.4.sdk/usr/lib"])
            target = self.project_target
            target_name = os.path.basename(target)[:-4]
            print("target_name: ",target_name)
            path = "%s/%s.xcodeproj/project.pbxproj" % (target, target_name)
            # project = XcodeProject.load(path)
            project = self.project
            sources = project.get_or_create_group("Sources")
            sources_list = set([child._get_comment() for child in sources.children])
            
            for src in sources.children:
                ID = str(src)
                file = src._get_comment()
                if file in ["main.m"]:
                    project.remove_file_by_id(ID)
            try:
                project.remove_group_by_name("Classes")
            except:
                print("removing classes failed")
            classes = project.get_or_create_group("Classes")
            classes_list = set([child._get_comment() for child in classes.children])
            with open(join(self.app_dir,"project_build_files","runMain.m"), "r") as f:
                main_string = f.read()
            with open(join(self.project_target,"runMain.m"), "w") as f:
                f.write(main_string.replace("{$project_path}",self.root_path))
            if not exists(join(self.project_target,"runMain.h")):
                shutil.copy(join(self.app_dir,"project_build_files","runMain.h"), join(self.project_target,"runMain.h"))
            for item in ("runMain.h","runMain.m"):
                if item not in classes_list and item != ".DS_Store":
                    project.add_file(join(self.project_target,item), parent=classes)
                    project_updated = True

                        
            for (dirpath, dirnames, filenames) in os.walk(join(self.app_dir, "project_build_files")):
                for item in filenames:
                    if item not in sources_list and item != ".DS_Store" and item.lower().endswith(".swift"):
                        dst = join(self.project_target,item)
                        shutil.copy(join(dirpath,item),dst)
                        #print(dirpath,item)
                        project.add_file(dst, parent=sources)
                        project_updated = True
            pro_file = ""
            with open(path, "r") as f:
                pro_file = f.read()
            update_bridge = False
            bridge_header = join(self.project_target,f"{target_name}-Bridging-Header.h")
            if not exists(bridge_header):
                bridge_strings = [
                    "\n#import \"runMain.h\"",
                    "\n\n",
                    "//#Wrappers Start",
                    "//  Insert Your Wrapper Headers Here -> #import \"wrapper_class_name\".h//  ",
                    "\n",
                    "//#Wrappers End",
                    "\n\n",
                    "//Insert Other OBJ-C Headers Here:"

                ] 
                with open(bridge_header, "w") as b:
                    b.write("\n".join(bridge_strings))
            project.set_flags("SWIFT_OBJC_BRIDGING_HEADER",f"{target_name}-Bridging-Header.h")
            project.set_flags("SWIFT_VERSION","5.0")
            project.set_flags("IPHONEOS_DEPLOYMENT_TARGET","11.0")


            project.add_file(bridge_header, parent=classes, force=False)

            project.add_header_search_paths(join(self.root_path,"wrapper_headers"),False)

            if project_updated:
                project.backup()
                project.save()

    

    def build_wdog_event(self,filename,new=False):
        print("build_wdog_event",new)
        d = self.db.get_item(filename)
                #print(d)
        if d:
            self.check_file_dates(d, filename)
            compiled = d["compiled"]
            build_date = d["build_date"]
            is_build = d["is_build"]
        else:
            is_build = 0
            compiled = 0
        if not new:
            wrap:WrapperFileNode = self.wrap_dict[filename]
            wrap.update_compile(compiled)
            self.build_selected(wrap)
 

    def wdog_thread(self):
        event_handler = EventHandler(self)
        observer = Observer()
        observer.schedule(event_handler, join(self.root_path,"wrapper_sources"), recursive=True,)
        observer.start()

    @mainthread
    def post_compile(self,py_sel):
        print("post_compile",py_sel)
        self.db.update_key(py_sel.text, "compiled", 1)
        #Clock.schedule_once(self.update_compile_icon,1)
        py_sel.update_compile(1)
        #self.selected_py.dispatch("compiled", 1)
        print(py_sel.compiled)
    
    def update_compile_icon(self,dt):
        self.selected_py.compiled = 0

    def compile_selected(self,btn):
        
        #applescript.tell.app("Terminal","ls")
        if self.db.wrap_exist(btn.title):
            title = self.db.get_item(btn.title)["class_title"]
            self.build_log.text = "Compiling:\n"
            print(f"Compiling: {title} ........... ")
            #self.build_log.text.__add__("Compiling:\n")
            #self.build_popup.open()
            self.sub_view.current = "log_screen"
            thread = Thread(target=self.compiler,args=[btn,title,False])
            thread.start()
    
    def print_date(self,sec):
        lt = localtime(sec)
        lt.tm_hour
        date = datetime(
            lt.tm_year, 
            lt.tm_mon,
            lt.tm_wday,
            lt.tm_hour, 
            lt.tm_min,
            lt.tm_sec)
        return "\n%s\n" % date.strftime("%m/%d/%Y, %H:%M:%S")
    
    def check_file_dates(self, d: dict, file: str ) -> dict:
        compile_dir = join(self.root_path,"dist/lib")
        comp_test = {"AppleApi"}
        compile_dir_files = set(os.listdir(compile_dir))
        class_title = d["class_title"]
        py_date = d["py_date"]
        build_date = d["build_date"]
        new_py_date = getmtime( join(self.root_path,"wrapper_sources",d["py_file"]) )
        if new_py_date > py_date:
            d["py_date"] = new_py_date
            py_date = new_py_date
            self.db.update_key(file, "py_date", new_py_date)

        for comp_item in compile_dir_files:
            #print(class_title,comp_item)
            #for comp in comp_test:
            if re.search(".*%s" % class_title,comp_item):
                comp_date = getmtime(join(compile_dir, comp_item))
                
                #print("comp date",self.print_date(comp_date),"py date",self.print_date(py_date) )
                #print("comp_date < py_date", (comp_date <= py_date))
                if comp_date < py_date:
                    comp_status = -1
                else:
                    comp_status = 1

                if build_date < py_date:
                    build_status = -1
                else:
                    build_status = 1
                self.db.update_key(file, "is_build", build_status)
                d["is_build"] = build_status
                self.db.update_key(file, "compiled", comp_status)
                d["compiled"] = comp_status
                break
        return d

    def create_project(self,title,path):
        command = " ".join([toolchain, "create", title, path])  # the shell command
        # self.execute(command,0,False)
        subprocess.run(command, shell=True)
        self.project_target = join(self.root_path,f"{title}-ios")
        self.update_classes_group()
        t = ProjectFileNode(
                        text= f"{title}-ios",
                        path= self.project_target
                        )
        #if hasattr(self,"project_tv"):
        p_tv = self.project_tv

        p_tv.add_node(t,self.xcode_projects)
        self.projects.append(t)

    def show_projects(self):
        self.xcode_projects = TreeGroup( text="Xcode Projects:",
                                        is_open=True,
                                        no_selection=True
                                        )
        self.project_tv.add_node(self.xcode_projects)
        self.project_tv.add_node(TitleNode2(),self.xcode_projects)

        import_dir = join(self.root_path)
        for item in os.listdir(import_dir):
            file_path = join(self.root_path,item)
            if isdir(file_path):
                if search(".*ios",item):
                    for xcode_file in os.listdir(join(import_dir,file_path)):
                        if xcode_file.endswith("xcodeproj"):
                            t = ProjectFileNode(
                                text=item,
                                path=join(file_path)
                                )
                            self.project_tv.add_node(t,self.xcode_projects)
                            self.projects.append(t)
                            break
     
    def show_imports(self):
        #imports:GridLayout = self.imports
        #imports.clear_widgets()

        self.wrappers.clear()
        if self.wrapper_files:
            self.tv.remove_node(self.wrapper_files)
            #del self.wrapper_files
        
        #if not self.wrapper_files:
        self.wrapper_files = TreeGroup( text="Wrapper Files:",
                                        is_open=True,
                                        no_selection=True
                                        )
        self.tv.add_node(self.wrapper_files)
    
        self.tv.add_node(TitleNode(),self.wrapper_files)
        #import_dir = join(self.app_dir,"imported_pys")
        import_dir = join(self.root_path,"wrapper_sources")
        for item in os.listdir(import_dir):
            if item.endswith("py"):
                d = self.db.get_item(item)
                #print(d)
                if d:
                    self.check_file_dates(d, item)
                    compiled = d["compiled"]
                    
                    is_build = d["is_build"]
                    
                else:
                    is_build = 0
                    compiled = 0

                t = WrapperFileNode(
                    text=item,
                    is_build = is_build,
                    compiled= compiled
                    )
                # t = ToggleButton(
                #     text= item,
                #     group=self.group,
                #     size_hint_y=None,
                #     height=48
                # )
                t.type = "imports"
                #t.bind(on_press=self.btn_action)
                # with open(join(root_path,"imported_pys",item)) as f:
                t.title = item
                #imports.add_widget(t)
                self.tv.add_node(t,self.wrapper_files)
                self.wrap_dict[item] = t
                self.wrappers.append(t)
    
    def show_builds(self,*args):
        builds:GridLayout = self.builds
        builds.clear_widgets()
        
        for item in os.listdir(join(self.app_dir,"builds")):
            #print(item)
            try:
                if os.path.isdir(join(self.app_dir,"builds",item)):
                    if os.path.exists(join(self.app_dir,"builds",item,"module.ini")):
                        with open(join(self.app_dir,"builds",item,"module.ini")) as f:
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

    def btn_action(self,view: TreeView,btn:TreeViewNode):
        # if btn.state is 'normal':
        #     btn.state = 'down'
        #     print(btn.text)
        if isinstance(btn, (TreeGroup,TitleNode)):
            return

        path = join(self.root_path,"wrapper_sources",btn.text)
        with open(path, 'r') as pyfile:
            self.new_view.text = pyfile.read()
        #path = join(self.app_dir,"imported_pys",btn.text)
        
        #if btn.state is 'down':
        self.selected_py = btn
        exist = self.db.wrap_exist(btn.text)
        if self.sub_view.current != "code_screen":
            self.sub_view.current = "code_screen"
        if not exists:
            pass
        # if btn.type == "imports":
        #     self.command0.text = "Build Selected"
        #     self.command1.text = "Build All"
        #     self.mode = 0
        #     with open(path, 'r') as pyfile:
        #         print(path)
        #         self.view1.text = pyfile.read()
        #         self.view2.text = ""
        #         self.view3.text = ""
        #         self.view1.scroll_y = 0
        # else:
        #     self.command0.text = "Compile Selected"
        #     self.command1.text = "Compile All"
        #     self.mode = 1

    def compiler(self,py_sel,calltitle,refresh_framework=False):
        #build_file = join(root_path,"builds",calltitle,"module_name.json")
        print(f"compiler {calltitle.lower()}")
        build_file = join(self.app_dir,"builds",calltitle.lower(),"kivy_recipe.py")
        build_file_exist = os.path.exists( build_file )
        #target_path = join(self.kivy_recipes,calltitle)
        
        target_path = join(self.root_path,"wrapper_builds",calltitle)
        if not os.path.exists( target_path ):
            os.makedirs(target_path)
        recipe_path = join(target_path,"__init__.py")
        print(recipe_path, os.path.exists( recipe_path ) , build_file, build_file_exist)
        #if os.path.exists( recipe_path ) and build_file_exist:
        if os.path.exists( recipe_path ) and build_file_exist:
            print("__init__.py Exists")
            if not cmp(build_file,recipe_path):
                print("Updating __init__.py")
                shutil.copy(build_file,recipe_path)
        else:
            if build_file_exist:
                shutil.copy(build_file,recipe_path)
            else:
                return
        try:
            remove_cache_file( join(self.root_path,".cache",calltitle+"-master.zip") )
        except:
            pass
        print("Cleaning",calltitle)
        self.update_log("\t%s\n\n" % calltitle)
        self.update_log("Cleaning Build\n")
        command = " ".join([toolchain, "clean", calltitle])  # the shell command
        self.execute(command,2,True)
        self.update_log("Building....\n")
        # command = " ".join([toolchain, "build", calltitle])  # the shell command
        command = " ".join([toolchain, "build", calltitle,"--add-custom-recipe", target_path])  # the shell command
        print(target_path)
        self.execute(command,1, True,True)
        #self.update_log("Building....")
        # if self.project_target:
        #     command = " ".join([toolchain, "update", self.project_target])  # the shell command
        #     self.execute(command)
        if refresh_framework:
            self.update_frameworks([calltitle])
        #remember
        #self.update_build_dict(calltitle.lower())

        # command = " ".join(['python3.7',toolchain, "clean", calltitle])  # the shell command
        # self.execute(command)
        # command = " ".join(['python3.7',toolchain, "build", calltitle])  # the shell command
        # self.execute(command)
        # command = " ".join(['python3.7',toolchain, "clean", calltitle])  # the shell command
        # self.execute(command)
        try:
            remove_cache_file( join(self.root_path,".cache",calltitle+"-master.zip") )
        except:
            print("remove cache faled")
        print("post comp")
        self.post_compile(py_sel)



    def execute(self,command,debug_info = 0,log = False, last =False):
        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        d_info = [b"", b"[DEBUG   ]", b"[INFO    ]"][debug_info]
        # Poll process for new output until finished
        if log == True:
            while True:
                nextline = process.stdout.readline()
                if nextline == b'' and process.poll() is not None:
                    break
                #[DEBUG   ]
                #[INFO    ]

                if nextline.startswith(d_info):
                    line = nextline.decode('utf-8')
                    self.update_log(line)
                sys.stdout.flush()
            if last == True:
                self.update_log("\nCompile Complete\n")
        
                

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


    def node_info(self,view,node):
        try:
            print(node.text)
        except:
            pass
    def on_selected_project_node(self,tv,node: ProjectFileNode):
        print(tv,node)
        self.selected_project_node = node

    def select_project(self):
        
        node: ProjectFileNode = self.selected_project_node
        print("select_project",node)
        if node:
            self.project_target = node.path
            print(self.projects)
            for _node in self.projects:
                if node == _node:
                    _node.project_selected = 1
                else:
                    _node.project_selected = 0

    def build(self):
        self.main = MainWindow()
        ids = self.main.ids
        #print(self.main.ids)
        # self.codeviews: CodeViews = self.main.ids.codeviews
        self.tv = ids.main_menu.wrapper_tree
        self.project_tv = ids.project_menu.project_view

        self.tv.bind(selected_node=self.node_info)
        self.tv.bind(selected_node=self.btn_action)
        self.project_tv.bind(selected_node=self.on_selected_project_node)
        #print(self.codeviews.ids)
        # print("working dir:",self.app_dir)
        # self.imports = ids.imports
        # self.builds = ids.builds
        # self.sm:ScreenManager = ids.screens
        # self.command0: Button = ids.command0
        # self.command0.bind(on_press=self.command_actions)
        # self.command0.idx = 0
        # self.command1: Button = ids.command1
        # self.command1.bind(on_press=self.command_actions)
        # self.command1.idx = 1
        # self.command2: Button = ids.command2
        # self.command2.bind(on_press=self.command_actions)
        # self.command2.idx = 2
        self.sub_view = ids.main_menu.ids.sub_screen1
        # codes = self.codeviews
        # codes.ids.view1.ids.label.text = "Python Code"
        # codes.ids.view2.ids.label.text = "Cython .pyx"
        # codes.ids.view3.ids.label.text = "OBJ-C .h"
        # self.view1: CodeInput = codes.ids.view1.ids.code
        # self.view2: CodeInput = codes.ids.view2.ids.code
        # self.view2.lexer = CythonLexer()
        # self.view3: CodeInput = codes.ids.view3.ids.code
        # self.view3.lexer = ObjectiveCLexer()

        self.new_view: CodeInput = ids.main_menu.ids.py_code
        self.show_imports()
        self.show_projects()
        # self.show_builds(None)
        self.build_log: TextInput = ids.main_menu.ids.build_log
        # self.build_log = TextInput(
        # )
        # self.build_log.background_color = [0, 0, 0, 1]
        # self.build_log.foreground_color = [0, 1, 0, 1]
        # self.build_log.readonly = True
        # self.build_popup = ModalView()
        # self.build_popup.size_hint = (0.8,0.8)
        # self.build_popup.add_widget(self.build_log)
        from kivy.config import ConfigParser

        config = ConfigParser()
        config.read('myconfig.ini')
        config.setdefaults('BuildInfo', { 'project_target':None})
        self.conf = config
        if config["BuildInfo"]["project_target"] == "":
            self.project_target = None
        else:
            self.project_target = config["BuildInfo"]["project_target"]
        
        self.load_xcode_project()
        #print(self.project.objects)
        #
        export_list = []
        # for obj in self.project.objects:
        #     print(type(obj))
        #     if obj:
        #         export_list.append(obj.__repr__)
        # with open(join(self.root_path,"project_export.txt"), 'w') as f:
        #     sys.stdout = f # Change the standard output to the file we created.
        #     print(self.project.objects)
        

        #self.settings_cls = SettingsWithTabbedPanel
        s = Settings()
        s.add_json_panel('BuildInfo', config, join(self.app_dir,'app_config.json'))
        ids.settings_box.add_widget(s)
        s.bind(on_config_change=self.on_config_change)

        
        #n1 = tv.add_node(TreeViewLabel(text='Item 1'))
        
        #s.add_json_panel('Another panel', config, 'settings_test2.json')
        # if self.project_target:
        #     ids.file_man.path = self.project_target
        return self.main


    def load_xcode_project(self):
        if self.project_target:
            try:
                target = self.project_target
                target_name = os.path.basename(target)[:-4]
                print("target_name: ",target_name)
                path = "%s/%s.xcodeproj/project.pbxproj" % (target, target_name)
                self.project = XcodeProject.load(path)
            # for 
            except:
                print("project failed invalid path:", str(self.project_target))
                return
            

    def on_config_change(self,s, config, section, key, value):
        if section == "BuildInfo":
            if key == "project_target":
                self.project_target = value
                #self.load_xcode_project()
if __name__ == '__main__':
    KivySwiftLink().run()
    #_json_store.update(_json)