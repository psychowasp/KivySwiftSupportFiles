import sys
import os
import subprocess
import shutil
from os.path import dirname, abspath, join, exists
from pbxproj import XcodeProject,PBXKey
from pbxproj.pbxextensions.ProjectFiles import FileOptions
from typing import *
toolchain = "toolchain"

BRIDGE_STRING = """
#import \"runMain.h\"
//#Wrappers Start"
#import "wrapper_typedefs.h"
//#Wrappers End
//Insert Other OBJ-C Headers Here:
"""


class ProjectCreator:
    bridge_header: str
    
    def __init__(self, root_path, app_dir):
        self.app_dir = app_dir
        self.root_path = root_path
        self.project_target = root_path
        self.bridge_header = None

    def create_project(self,title,path):
        print(title, path)
        subprocess.run(f"toolchain create {title} {path}", shell=True)
        self.project_target = join(self.root_path,f"{title}-ios")
        self.update_classes_group()
        subprocess.run(f"toolchain xcode {title}-ios", shell=True)

    def load_xcode_project(self):
        if self.project_target:
            try:
                target = self.project_target
                target_name = os.path.basename(target)[:-4]

                print("target_name: ",target_name, self.project_target)
                path = f"{target}/{target_name}.xcodeproj/project.pbxproj"
                self.project = XcodeProject.load(path)
            # for 
            except:
                print("project failed invalid path:", str(path))
                return
            bridge_header = join(self.project_target,f"{target_name}-Bridging-Header.h")
            if exists(bridge_header):
                self.bridge_header = bridge_header

    def add_swift_files(self,group,files_dir):
        #print("adding swift files", files_dir)
        #self.load_xcode_project()
        project = self.project
        project_updated = False
        sources = project.get_or_create_group("Sources")
        _group = project.get_or_create_group(group,parent = sources)
        group_dir = join(self.project_target,group)
        if not exists(group_dir):
            os.mkdir(group_dir)
        for (dirpath, dirnames, filenames) in os.walk(files_dir):
            for item in filenames:
                file = join((dirpath, dirnames, filenames))
                is_dir = os.path.isdir(file)
                if item != ".DS_Store" and item.lower().endswith(".swift"):
                    #print(item,join(self.project_target,item))
                    
                    shutil.copy(join(dirpath,item), group_dir )
                    has_file = project.get_files_by_name(item, _group)
                    if len(has_file) == 0:
                        project.add_file(join(group_dir,item), parent=_group)
                        project_updated = True
                    else:
                        print("has_file: ",has_file)
        self.update_bridging_header(["kivytest"]) 

        if project_updated:
            project.backup()
            project.save()


    def update_bridging_header(self, keys: List[str]):
        header = self.bridge_header
        keys.insert(0, "wrapper_typedefs")
        if header:
            with open(self.bridge_header, "r") as f:
                header_string = f.readlines()
            header_export = [*header_string]
            for i, line in enumerate(header_string):
                if "//#Wrappers Start" in line:
                    wrap_start = i
                if "//#Wrappers End" in line:
       
                    wrap_end = i
                    break
            

            for key in keys:
                has_key = False
                s_key = f"#import \"{key}.h\""
                for i, line in enumerate(header_string[wrap_start:wrap_end]):
                    if s_key in line:
                        has_key = True
                        break
                if not has_key:
                    header_export.insert(wrap_start + 1,f"{s_key}\n")
        
            with open(self.bridge_header, "w") as f:
                f.write("".join(header_export))

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
            #print("target_name: ",target_name)
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
            project_support_files = join(self.root_path,"project_support_files")
            classes = project.get_or_create_group("Classes")
            classes_list = set([child._get_comment() for child in classes.children])
            with open(join(project_support_files, "runMain.m"), "r") as f:
                main_string = f.read()
            with open(join(self.project_target,"runMain.m"), "w") as f:
                f.write(main_string.replace("{$project_path}",self.root_path))
            if not exists(join(self.project_target,"runMain.h")):
                shutil.copy(join(project_support_files,"runMain.h"), join(self.project_target,"runMain.h"))
            for item in ("runMain.h","runMain.m"):
                if item not in classes_list and item != ".DS_Store":
                    project.add_file(join(self.project_target,item), parent=classes)
                    project_updated = True

            EXCLUDE_FILES = ["old_PythonSupport.swift"]
            for (dirpath, dirnames, filenames) in os.walk(project_support_files):
                for item in filenames:
                    if item not in sources_list and item != ".DS_Store" and item.lower().endswith(".swift"):
                        if item not in EXCLUDE_FILES:
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
            self.bridge_header = bridge_header
            if not exists(bridge_header):
                with open(bridge_header, "w") as b:
                    b.write(BRIDGE_STRING)
            project.set_flags("SWIFT_OBJC_BRIDGING_HEADER",f"{target_name}-Bridging-Header.h")
            project.set_flags("SWIFT_VERSION","5.0")
            project.set_flags("IPHONEOS_DEPLOYMENT_TARGET","11.0")


            project.add_file(bridge_header, parent=classes, force=False)

            project.add_header_search_paths(join(self.root_path,"wrapper_headers"),False)

            if project_updated:
                project.backup()
                project.save()