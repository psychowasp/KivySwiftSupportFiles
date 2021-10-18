from KivySwiftLink.build_files.pack_files import pack_all,remove_cache_file, create_package
from KivySwiftLink.pythoncall_builder import PythonCallBuilder
from KivySwiftLink.create_project import ProjectCreator
import sys
import os
import subprocess
import shutil
import json
from argparse import ArgumentParser
from os.path import dirname, abspath, join, exists,splitext
from pprint import pprint
toolchain = "toolchain"

class BuildHandler:
    app_dir: str
    root_path: str

    def __init__(self, app_dir, root_path):
        self.app_dir = app_dir
        self.root_path = root_path


    def build_single(self, file: str, project: str):
        app_dir, root_path = self.app_dir, self.root_path

        name = file.split(".")[0]
        p_build = PythonCallBuilder(app_dir, root_path)

        p_build.build_py_files(
            join(root_path,"wrapper_sources",file) 
            )

        
        build = True
        if build:
            cmd = f"toolchain clean {name}"
            subprocess.run(cmd,  shell=True, stdout=None, stderr=None)

            cmd = f"toolchain build {name} --add-custom-recipe {join(root_path, 'wrapper_builds', name)}"
            subprocess.run(cmd, shell=True)

            cmd = f"toolchain update {project}-ios --add-custom-recipe {join(root_path, 'wrapper_builds', name)}"
            subprocess.run(cmd, shell=True)

    

    def build_all(self, project_name: str ):
        app_dir, root_path = self.app_dir, self.root_path
        path = join(root_path,"wrapper_sources")
        names = []
        for root, dirs, files in os.walk(path):
            for file in files:
                if file != ".DS_Store":
                    print(file)
                    self.build_single(file, project_name)
                    names.append(splitext(file)[0])
        
        project = ProjectCreator(root_path, app_dir)
        project.project_target = join(root_path,f"{project_name}-ios")
        project.load_xcode_project()
        project.update_bridging_header(names)
        recipes_list = [join(root_path, 'wrapper_builds', n) for n in names]
        # cmd = f"toolchain update {args.project_name}-ios --add-custom-recipe {' '.join(recipes_list)}"
        # subprocess.run(cmd, shell=True)






    def install_extensions(self, extension:dict ):
        app_dir, root_path = self.app_dir, self.root_path
        project = ProjectCreator(root_path, app_dir)

        self._install_extensions(extension, project, root_path)

    def _install_extensions(self, extension:dict ,project: ProjectCreator, root_path: str):
        project_name = kw.get("project")
        project.project_target = join(root_path,f"{project_name}-ios")
        project.load_xcode_project()
        path = extension.get('path')
        group = extension.get('extension_name')

        project.add_swift_files(group,path)
        # for root, dirs, files in os.walk(path):
        #     for file in files:

                
        #         print(file)

    def create_project_with_extensions(self, extension:dict):
        app_dir, root_path = self.app_dir, self.root_path
        project = ProjectCreator(root_path, app_dir)

    def find_wrapper_files(self, path: str):
        py_files = []
        for root, dirs, files in os.walk(path):
            if root == path:
                for file in files:
                    _file_, ext = splitext(file)
                    if ext == '.py':
                        py_files.append(join(root,file))
        return py_files

    def select_project(self, project: str):
        project_path = join(root_path, f"{args.project_name}-ios")
        DB_FILE = join(self.app_dir,"ksl_settings.json")
        if exists(DB_FILE):
            with open(DB_FILE, 'r') as f:
                db_data = json.load(f)
            db_data["current_project"] = [project, project_path]
        else:
            db_data = {
                "current_project": [project, project_path]
            }
        with open(DB_FILE, 'w') as f:
            json.dump(db_data, f)
    
    def get_project(self):
        DB_FILE = join(self.app_dir,"ksl_settings.json")
        if exists(DB_FILE):
            with open(DB_FILE, 'r') as f:
                db_data = json.load(f)
                return db_data["current_project"]
        return None



if __name__ == '__main__':
    
    p = ArgumentParser()
    sub_parsers = p.add_subparsers(dest="cmd")

    build_args = sub_parsers.add_parser('select_project')
    build_args.add_argument('project_name')

    build_args = sub_parsers.add_parser('build')
    build_args.add_argument('filename')
    #build_args.add_argument('project_name')

    build_args = sub_parsers.add_parser('build_all')
    #build_args.add_argument('project_name')

    create_args = sub_parsers.add_parser('create')
    create_args.add_argument("project_name")
    create_args.add_argument('python_source_folder')

    create_args = sub_parsers.add_parser('install_extension')
    create_args.add_argument('folder_path')
    #create_args.add_argument("project_name")
    


    args = p.parse_args()

    T = args.cmd
    s = sub_parsers

    root_path = os.getcwd()
    app_dir = abspath(dirname(__file__))
    handler = BuildHandler(app_dir, root_path)
    current_project = handler.get_project()

    if T == "build":
        if not current_project:
            print("No project selected, use \"select_project\" cmd to set it.")
            exit(1)
        project = current_project[0]
        print(f"Building {args.filename}")
        _file_ = args.filename
        handler.build_single(
            _file_,
            project
        )
        name = splitext(_file_)[0]
        project = ProjectCreator(root_path, app_dir)
        project.project_target = current_project[1]
        project.load_xcode_project()
        project.update_bridging_header([name])
        



    elif T == "build_all":
        if not current_project:
            print("No project selected, use \"select_project\" cmd to set it.")
            exit(1)
        handler.build_all(current_project[0])





    elif T == "create":
        print("Creating project", args.project_name, args.python_source_folder)
        project = ProjectCreator(root_path, app_dir)
        project.create_project(args.project_name, args.python_source_folder)


    elif T == "select_project":
        #project = join(root_path, f"{args.project_name}-ios")
        handler.select_project(args.project_name)


    elif T == "install_extension":
        if not current_project:
            print("No project selected, use \"select_project\" cmd to set it.")
            exit(1)
        _dir_ = args.folder_path
        print("Installing Extension",_dir_)
        with open(join(_dir_,"setup.json")) as f:
            kw = json.load(f)

        #py_files = find_wrapper_files(_dir_)
        py_files = [join(_dir_,wrap) for wrap in kw.get("wrappers")]
        #install_extensions(kw, app_dir, root_path)
        for file in py_files:
            shutil.copy(file, join(root_path, "wrapper_sources"))
            filebase = os.path.basename(file)
            handler.build_single(filebase)
        
        kw["project"] = args.project_name
        kw["path"] = join(_dir_, "swift_sources")

        handler.install_extensions(kw)


    exit(1)

    # elif t == "create_with_extensions":
    #     kw = {

    #     }
    #     create_project_with_extensions()

    