
import ast
from ast import *

import astor
import json

import platform 
from typing import List
from pathlib import Path

OSX_VERSION = ".".join(platform.mac_ver()[0].split(".")[:-1])
PY_VERSION = ".".join(platform.python_version_tuple()[:-1])

class PyWrapClass:

    def __init__(self):
        super(PyWrapClass, self).__init__()

    @staticmethod
    def json_export(wrap_title: str, string:str) -> str:
        module = ast.parse(string.replace("List[","["))
        wrap_list = []

        for class_body in module.body:
            
            if isinstance(class_body,ast.Assign):
                pass
            
            if isinstance(class_body,ast.ClassDef):
                wrap_class = PyWrapClass()
                js = wrap_class.parse_code_json(class_body)
                #wrap_class.parse_code(class_body)
                #wrap_class.setup_callback_type()
                wrap_list.append(js)
        wrap_module = {
            "filename": wrap_title,
            "classes": wrap_list
        }
        return json.dumps(wrap_module)


        
        
    

    def parse_code_json(self,class_body):
        functions = []
        self.export_dict = {
            "title": class_body.name,
            "functions": functions,
            "decorators": []
        }
        self.calltitle = class_body.name
        
        self.handle_class_decorators(class_body)
        #self.gen_send_start_function(send_functions)
        self.handle_class_children(class_body.body)

        return self.export_dict

    def handle_class_decorators(self,class_body: ast.ClassDef):
        decorators = class_body.decorator_list
        for dec in decorators:

            if isinstance(dec,ast.Call):
                id: ast.Name = dec.func.id
            else:
                id = dec.id

        if id == "EventDispatcher":
            if len(dec.args) != 0:
                events: ast.List = dec.args[0]
                _events_ = [event.value for event in events.elts]
                d = {
                    "type": "EventDispatch",
                    "args": [json.dumps({
                        "events": _events_
                        })]
                    
                }
                self.export_dict["decorators"].append(d)


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

            elif t == "swift_func":
                func_dict["swift_func"] = True
            
            elif t == "call_target":
                func_dict["call_target"] = decorator.args[0].value
            
            elif t == "call_class":
                func_dict["call_class"] = decorator.args[0].value
            
            elif t == "call_object":
                func_dict["call_object"] = decorator.args[0].id
            
            

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
            "returns": _return_,
            "is_callback": False,
            "swift_func": False,
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
