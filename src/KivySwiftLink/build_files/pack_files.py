
import os
from posixpath import splitext
import zipfile
import sys
import shutil
import configparser
import json
import glob
from os.path import join

root_path = os.path.dirname(sys.argv[0])

def zipdir(path,src, ziph):
    # ziph is zipfile handle
    for root, dirs, files in os.walk(path):
        for file in files:
            if file != ".DS_Store":
                #ziph.write(os.path.join(root, file),root)
                ziph.write(os.path.join(root, file), arcname=os.path.join(root.replace(path, "files"), file))
                _file,ext = file.split(".")
                #print(_file,ext)
        if len(dirs) != 0:
            src.append((root,dirs))

def clear_temp(root):
    src = join(root,"tmp")
    if os.path.exists(src):
        #print("tmp exist")
        shutil.rmtree(src)
        # for item in os.listdir(src):
        #     s = os.path.join(src, item)
        #     if os.path.isdir(s):
        #         shutil.rmtree(s)

def remove_cache_file(src):
    print("remove_cache_file",src)
    if os.path.exists(src):
        os.remove(src)
            

def create_temp_copy_files(app_dir,root_path,src,dst,key):
    modules = {}
    src_folder = join(dst,"src")
    #config = configparser.ConfigParser()
    wrapper_headers = join(root_path,"wrapper_headers")

    if not os.path.exists(src_folder):
        os.makedirs(src_folder)
    for root, dirs, files in os.walk(src):
        #print("create_temp_copy_files",root,dirs,files)
        for file in files:
            #print("checking",root,"vs",join(src, key))
            if file != ".DS_Store" and root == join(src, key):
                
                #print("create_temp_copy_files",root,dirs,files)
                s = os.path.join(root, file)
                d = os.path.join(src_folder, file)
                name,ext = splitext(file)
                parent_dir = dst
                if file == 'module.ini':
                    pass
                    # with open(s, 'r') as configfile:
                    #     #print(configfile.read())
                    #     _str = configfile.read()
                    #     #print(_str)
                    #     _list = json.loads(_str)
                    #     _key,_dict = _list
                    #     modules[_key] = _dict
                    #     configfile.close()
                elif file == "kivy_recipe.py":
                    pass
                    # print("kivy_recipe", d)
                    # shutil.copy(s,join(dst,"__init__.py"))
                else:
                    shutil.copy(s,d)
                if ext == ".h":
                    shutil.copy2(join(root, f"_{key}.h"), join(wrapper_headers,f"{key}.h"))
    shutil.copy2(join(app_dir, "wrapper_typedefs.h"), src_folder)
    ### remember to uncomment this
    #if not os.path.exists(join(wrapper_headers,"wrapper_typedefs.h")):
    shutil.copy2(join(app_dir, "wrapper_typedefs.h"), wrapper_headers)
    # for item in os.listdir(src):
    #     s = os.path.join(src, item)
    #     d = os.path.join(dst, item)
    #     if os.path.isdir(s):
    #         shutil.copytree(s, d, False, None)
    
    #print(root_path)
    shutil.copy(join(app_dir,"build_files/Setup.py"),src_folder)
    shutil.copy(join(app_dir,"build_files/files_list.py"),src_folder)
    
    with open(os.path.join(src_folder,"compile_modules.ini"), 'w') as configfile:
        configfile.write(json.dumps(modules,indent=4))
        configfile.close()


def create_package(root_dir, app_dir, name):
    clear_temp(app_dir)
    
    builds = join(app_dir,"tmp")
    sources = []
    exports_path = join(root_dir,"wrapper_builds")
    export_dest = join(exports_path,name)
    if not os.path.exists(exports_path):
        os.makedirs(exports_path)
    if not os.path.exists( export_dest ):
        os.makedirs(export_dest)

    create_temp_copy_files(app_dir,root_dir ,join(app_dir,"builds"),export_dest,name.lower())
    


def pack_all(root_dir, app_dir, src, dst):
    clear_temp(app_dir)
    create_temp_copy_files(app_dir,join(app_dir,"builds"),join(app_dir,"tmp"),dst.lower())
    builds = join(app_dir,"tmp")
    sources = []
    exports_path = join(root_path,"wrapper_builds")
    #exports_path = join(app_dir,"Exports")
    if not os.path.exists(exports_path):
        os.makedirs(exports_path)
    if not os.path.exists(join(exports_path,dst) ):
        os.makedirs(join(exports_path,dst) )
    zipf = zipfile.ZipFile(join(exports_path,dst,src), 'w', zipfile.ZIP_DEFLATED)
    
    zipdir(builds,sources, zipf)
    # #zipf.write("build_files/Setup.py")
    build_files = os.path.join(root_path,"build_files")

    #zipf.write(os.path.join(build_files, "Setup.py"), arcname=os.path.join(build_files.replace(build_files, "files"), os.path.join(build_files, "Setup.py")))
    zipf.close()
    # #shutil.move('Exports/' + src,dst + src)
    files = glob.iglob(os.path.join(builds, "*.h"))
    for file in files:
        if os.path.isfile(file):
            shutil.copy2(file, join(app_dir,"cython_headers"))
            shutil.copy2(file, join(root_dir,"wrapper_headers",f"{dst}.h"))
    #shutil.copy(join(builds,"*.h"), join(app_dir,"cython_headers"))

if __name__ == '__main__':
    pack_all("Python.zip","Exports/cache/")
    