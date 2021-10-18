from functools import wraps
import parser
import ast
from ast import *
from uuid import uuid4
from time import time
import astor
from pprint import pprint
import re
import sys
import os
import subprocess
#from PythonSwiftLink.build_files.pack_files import pack_all,remove_cache_file
import configparser
import json
from os.path import join,exists
import shutil
import random
import string
import platform 
from typing import List
from pathlib import Path
# from KivySwiftLink.def_types import types2dict

# from KivySwiftLink.create_recipe import create_recipe, create_setup_py
# from KivySwiftLink.typedef_generator import load_c_types

OSX_VERSION = ".".join(platform.mac_ver()[0].split(".")[:-1])
PY_VERSION = ".".join(platform.python_version_tuple()[:-1])

class WrapClass2:

    def __init__(self):
        super(WrapClass2, self).__init__()

    @staticmethod
    def json_export(string:str) -> str:
        module = ast.parse(string.replace("List[","["))
        wrap_list = []

        for class_body in module.body:
            
            if isinstance(class_body,ast.Assign):
                pass
            
            if isinstance(class_body,ast.ClassDef):
                wrap_class = WrapClass2()
                js = wrap_class.parse_code_json(class_body)
                #wrap_class.parse_code(class_body)
                #wrap_class.setup_callback_type()
                wrap_list.append(js)
        wrap_module = {
            "filename": "wraptest.py".split(".")[0],
            "classes": wrap_list
        }
        return json.dumps(wrap_module)


        
        
    

    def parse_code_json(self,class_body):
        functions = []
        self.export_dict = {
            "title": class_body.name,
            "functions": functions
        }

        self.calltitle = class_body.name
        
        #_cdec = self.handle_class_decorators(class_body)
        
        #self.gen_send_start_function(send_functions)
        self.handle_class_children(class_body.body)

        return self.export_dict

    def handle_class_children(self,child):
        for cbody in child:
                
            if isinstance(cbody,ast.FunctionDef):
                self.handle_class_function(cbody)

    def handle_function_decorators(self, body: FunctionDef, func_dict: dict) -> List[str]:
        dec_list = []
        for decorator in body.decorator_list:
            
            if isinstance(decorator,ast.Call):
                t = decorator.func.id
            else:
                t = decorator.id
            
            if t == "callback":
                func_dict["is_callback"] = True


    def handle_class_function(self, body: ast.FunctionDef):
        #print("function: ",body.name)
        func_args = body.args.args
        functions: list = self.export_dict["functions"]
        arg_list = []
        returns = body.returns
        
        if returns:
            _return_ = {
            "name": returns.id,
            "type": returns.id,
            "idx": 0,
            "is_return": True
        }
        else:
            _return_ = {
            "name": "void",
            "type": "void",
            "idx": 0,
            "is_return": True
        }
        func = {
            "name": body.name,
            "args": arg_list,
            "is_callback": False,
            "returns": _return_
        }
        self.handle_function_decorators(body,func)
        
        functions.append(func)
        count = 0
        for arg in func_args:
            #print("\t",arg.arg, arg.annotation.id)
            is_list = False
            is_data = False
            if isinstance(arg.annotation, ast.List):
                is_list = True
                t = arg.annotation.elts[0].id
            else:
                t = arg.annotation.id

            if t == "jsondata":
                is_data = True
            arg_list.append(
                {
                    "name": arg.arg,
                    "type": t,
                    "is_list": is_list,
                    "idx": count
                }
            )
            if is_list or is_data:
                count += 1
                arg_list.append(
                {
                    "name": f"{arg.arg}_size",
                    "type": "int",
                    "is_counter": True,
                    "idx": count
                })
            count += 1
            
        #print()
        
