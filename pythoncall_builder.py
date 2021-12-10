
import ast
from ast import *

import astor
import json

import platform 
from typing import List
from pathlib import Path
from cython import struct



OSX_VERSION = ".".join(platform.mac_ver()[0].split(".")[:-1])
PY_VERSION = ".".join(platform.python_version_tuple()[:-1])

def parse_helper(string: str, d: dict):
    module = ast.parse(string)
    body_list = module.body
    for class_body in body_list:
        if isinstance(class_body,ast.ClassDef):
            #class_list = class_body.body
            
            #cbody_del_list = []
            for cbody in class_body.body:
                # if "callback" in dec_list:
                #     #class_body.body.remove(cbody)
                #     cbody_del_list.append(cbody)
                # else:
                if True:
                    cbody: ast.FunctionDef
                    for arg in cbody.args.args:
                        if isinstance(arg, ast.arg):
                            anno = arg.annotation
                        else:
                            anno = arg
                        if isinstance(anno, ast.Subscript):
                            _anno_ = anno
                            sub_id: str = _anno_.value.id
                            if sub_id == "list":
                                #is_list = True
                                t = _anno_.slice.id
                                _anno_.slice.id = d[t]
                            if sub_id == "tuple":
                                #print(_anno_.__dict__)
                                t = sub_id
                        else:
                            if isinstance(arg, ast.Name):
                                t = arg.id
                                arg.id = d[t]
                            else:
                                t = arg.annotation.id
                                arg.annotation.id = d[t]

                    cbody.args.args.insert(0,ast.arg(arg="self",annotation = None))
                    #cbody.args.args()
            
            # for rem_body in cbody_del_list:
            #     class_body.body.remove(rem_body)

    src = astor.to_source(module)
    return src

class PyWrapClass:
    types: list[str]
    def __init__(self):
        ...

    @staticmethod
    def json_export(wrap_title: str, string:str) -> str:
        module = ast.parse(string)
        wrap_list = []
        type_var_list = []
        
        for body in module.body:
            #print("\n")
            #print(body)


            if isinstance(body,ast.Assign):
                if isinstance(body.value, ast.Call):
                    assign_t = body.value.func.id

                    if assign_t == "struct":
                        #print(f"struct {''}: {body.value}")
                        type_var_list.append(json.dumps({
                            "type:": "struct",
                            "type_name": body.targets[0].id,
                            "args": [{"key": key.arg, "type": key.value.id} for key in body.value.keywords]
                        }))
            
            if isinstance(body,ast.ClassDef):
                wrap_class = PyWrapClass()
                js = wrap_class.parse_code_json(body)
                #wrap_class.parse_code(class_body)
                #wrap_class.setup_callback_type()
                wrap_list.append(js)
            
            #print("\n")
        #print(type_var_list)
        wrap_module = {
            "filename": wrap_title,
            "classes": wrap_list,
            "typevars": type_var_list
        }

       
        # with open("./class_export.json", "w") as f:
        #     json.dump(wrap_module, f)
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
            
       
    def handle_arg_type(self, arg, count: int, returns: bool) -> dict:
        #print("\t",arg.arg, arg.annotation.id)
        is_list = False
        is_data = False
        is_tuple = False
        other_type = False
        # print("\nhandle_arg_type:")
        # print("\treturn",returns,arg,arg.__dict__)
        
        #if returns:
        
        #if isinstance(arg, ast.arg):
        #if isinstance(arg, ast.Name):
        anno = None
        if isinstance(arg, ast.arg):
            anno = arg.annotation
        else:
            anno = arg
            
        
        if isinstance(anno, ast.Subscript):
            
            _anno_ = anno
            sub_id: str = _anno_.value.id
            #print("\t",sub_id)
            if sub_id == "list":
                is_list = True
                t = _anno_.slice.id
            if sub_id == "tuple":
                is_tuple = True
                
                #print(_anno_.__dict__)
                t = sub_id
                #Exception()

        
        else:
            # print("\tnot subscript")
            if isinstance(arg, ast.Name):
                t = arg.id
            else:
                t = arg.annotation.id


        if t in ["jsondata", "data"]:
            is_data = True
        
        if returns:
            return {
            "name": t,
            "type": t,
            "is_list": is_list,
            "is_data": is_data,
            "idx": 0,
            "is_return": True
        }
        
        return {
            "name": arg.arg,
            "type": t,
            "is_list": is_list,
            "is_data": is_data,
            "idx": count
        }

    

    def handle_class_function(self, body: ast.FunctionDef):
        #print("function: ",body.name)
        func_args = body.args.args
        functions: list = self.export_dict["functions"]
        arg_list = []
        returns = body.returns
        


        if returns:
            _return_ = self.handle_arg_type(returns, 0, True)
        else:
            _return_ = {
            "name": "void",
            "type": "void",
            "idx": 0,
            "is_return": True
        }
        #print("\treturn_data:", _return_)
        func = {
            "name": body.name,
            "args": arg_list,
            "returns": _return_,
            #"is_callback": False,
            #"swift_func": False,
        }
        self.handle_function_decorators(body,func)
        
        functions.append(func)
        count = 0
        for arg in func_args:
            #print("\t",arg.arg, arg.annotation.id)
            arg_data = self.handle_arg_type(arg,count,False)
            #print("\t",arg_data)
            arg_list.append(arg_data)
            count += 1
