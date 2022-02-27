
import ast
from ast import *
from pickle import FALSE

import astor
import json

import platform 
from typing import List
from pathlib import Path
from cython import struct

PRINTTAB = "\t"

OSX_VERSION = ".".join(platform.mac_ver()[0].split(".")[:-1])
PY_VERSION = ".".join(platform.python_version_tuple()[:-1])

def handle_imports(body: ast.ImportFrom):
    print(body.module.__dict__)
    
def handle_wrapped_class(class_body: ast.ClassDef, d: dict, pyi_mode: bool):
    for cbody in class_body.body:
        # if "callback" in dec_list:
        #     #class_body.body.remove(cbody)
        #     cbody_del_list.append(cbody)
        # else:

        if isinstance(cbody, ast.Assign):
            pass
        elif isinstance(cbody, ast.AnnAssign):
            pass
        else:
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
                        if t in d:
                            _anno_.slice.id = d[t]
                        else:
                            _anno_.slice.id = t
                    if sub_id == "tuple":
                        #print(_anno_.__dict__)
                        t = sub_id
                else:
                    if isinstance(arg, ast.Name):
                        t = arg.id
                        arg.id = d[t]
                    else:
                        if arg.arg != "self" or pyi_mode:
                            if arg.annotation:
                                t = arg.annotation.id
                                if t in d:
                                    arg.annotation.id = d[t]
                        
            if pyi_mode:
                cbody.args.args.insert(0,ast.arg(arg="self",annotation = None))
        
def parse_helper(string: str, d: dict, extra: str = ""):
    module = ast.parse(string)
    body_list = module.body
    excluded_classes = [] 
    for class_body in body_list:
        if isinstance(class_body,ast.ClassDef):
            #class_list = class_body.body
            
            bases = [base.id for base in class_body.bases]
            if "Codable" in bases:
                pass
            else:
            #cbody_del_list = []
                handle_wrapped_class(class_body, d, False)
                
                
                # for rem_body in cbody_del_list:
                #     class_body.body.remove(rem_body)
        elif isinstance(class_body, ast.Assign):
            handleGlobalAssigns(module,class_body)
            
    add_enums(module, extra)
    src = astor.to_source(module)
    return src

def add_enums(module: ast.Module, extra: str):
    mod = ast.parse(extra)
    for i, body in enumerate(mod.body):
        module.body.insert(i, body)
        

def handleGlobalAssigns(module:ast.Module, body: ast.Assign):
    value = body.value
    print("handleGlobalAssigns:")
    if isinstance(value, ast.Call):
        func = value.func
        id = func.id
        print(f"\tid: {func.id} {func}")
        print(f"\tfunc: {value.func}")
        print(f"\targs: {value.args}")
        print(f"\tkeywords: {value.keywords}")
        if id == "Enum":
            module.body.remove(body)
def get_class_decorators(body_list: list[ast.stmt]) -> list[str]:
    output = []
    for body in body_list:
        if isinstance(body, ast.Call):
            output.append(body.func.id)
            continue
        output.append(body.id)
    return output

def remove_class_decorator(body_list: list[ast.stmt], key: str):
    target = None
    for body in body_list:
        if isinstance(body, ast.Call):
            t = body.func.id
        else:
            t = body.id
        if t == key:
            target = body
            break
    if target:
        body_list.remove(target)

def extract_python_classes(string: str) -> str:
    module = ast.parse(string)
    body_list = module.body
    excluded_classes = [] 
    for class_body in body_list:
        if isinstance(class_body,ast.ClassDef):
            deco_list = get_class_decorators(class_body.decorator_list)
            if "python" in deco_list:
                remove_class_decorator(class_body.decorator_list,"python")
                continue
            
            excluded_classes.append(class_body)
    
    for imp in body_list:
        if isinstance(imp, ast.ImportFrom):
            if imp.module == "swift_types":
                body_list.remove(imp)
    
    for assign in body_list:
        if isinstance(assign, ast.Assign):
            if isinstance(assign.value, ast.Call):
                if assign.value.func.id == "Enum":
                    body_list.remove(assign)
    for cls in excluded_classes:
        module.body.remove(cls)

    src = astor.to_source(module)
    return src
    

def handle_arg_arg(arg: ast.arg, options: list[str]) -> str:
    anno = arg.annotation
    #print(PRINTTAB, type(arg.annotation))
    if isinstance(anno, ast.Name):
        return anno.id
    elif isinstance(anno, ast.Subscript):
        return handleSubscript(anno, options)

def handleSubscript(arg: ast.Subscript, options: list[str]) -> str:
    sub_id: str = arg.value.id
    if sub_id == "list":
        options.append("list")
        return arg.slice.id
    elif sub_id == "tuple":
        options.append("tuple")
        return sub_id
    elif sub_id == "array":
        options.append("array")
        return arg.slice.id
    else:
        if isinstance(arg.slice, ast.Slice):
            options.append("memoryview")
        return sub_id

def handle_AnnAssign(arg: ast.AnnAssign, options: list[str]) -> str:
    #print("\thandle_AnnAssign",arg.__dict__)
    return arg.annotation.id

def handle_arg_type(arg, count: int, returns: bool) -> dict:

    options: list[str] = []
    #if isinstance(arg, ast.arg):
    #if isinstance(arg, ast.Name):
    if isinstance(arg, ast.arg):
        #print("ast.arg")
        t = handle_arg_arg(arg, options)
    elif isinstance(arg, ast.AnnAssign):
        #print("ast.AnnAssign")
        t = handle_AnnAssign(arg,options)
    elif isinstance(arg, ast.Subscript):
        print("ast.Subscript")
    elif isinstance(arg, ast.Slice):
        print("ast.Slice")
    elif isinstance(arg, ast.Name):
        t = arg.id
    else:
        t = ""
    
        #print("ast.Other", type(arg), arg.__dict__)
    # anno = None
    # if isinstance(arg, ast.arg):      
    #     anno = arg.annotation
    #     #print("\tast.arg",arg.__dict__)
    # if isinstance(arg, ast.AnnAssign):
    #     anno = arg.annotation
    # else:
    #     anno = arg
    
    # print(PRINTTAB,type(anno),anno.__dict__)
    #t = handleSubscript(anno, options) 
    # if isinstance(anno, ast.Subscript):
        
    #     _anno_ = anno
    #     sub_id: str = _anno_.value.id
    #     print("\t",sub_id)
    #     if sub_id == "list":
    #         options.append("list")
    #         t = _anno_.slice.id
    #     elif sub_id == "tuple":
    #         options.append("tuple")
    #         t = sub_id
    #     elif sub_id == "array":
    #         t = _anno_.slice.id
    #         options.append("array")
    #     else:
    #         t = sub_id
    #         if isinstance(_anno_.slice, ast.Slice):
    #             options.append("memoryview")
        

    
    # else:
    #     # print("\tnot subscript")
    #     if isinstance(arg, ast.Name):
    #         t = arg.id
    #     else:
    #         _anno = arg.annotation
    #         if isinstance(_anno, ast.Name):
    #             t = _anno.id
    #         elif isinstance(_anno, ast.Subscript):
    #             print("\tslice", _anno.__dict__)
    #             t = _anno.slice.id


    if t in ["jsondata", "data"]:
        is_data = True
        options.append("data")
    
    if returns:
        return {
        "name": t,
        "type": t,
        # "is_list": is_list,
        # "is_data": is_data,
        "options": [*options,"return_"],
        "idx": 0,
        "is_return": True
    }
    if isinstance(arg, ast.AnnAssign):
        arg_name = arg.target.id
     
    else:
        arg_name = arg.arg
    return {
        "name": arg_name,
        "type": t,
        # "is_list": is_list,
        # "is_data": is_data,
        "options": options,
        "idx": count
    }


class PyWrapClass:
    types: list[str]
    properties: list[dict]
    
    def __init__(self, pyi_mode: bool = False):
        self.properties = []
        self.pyi_mode = pyi_mode
    
    
    
    


    # @staticmethod
    # def json_export(wrap_title: str, string:str) -> str:
    #     module = ast.parse(string)
    #     wrap_list = []
    #     custom_structs = []
    #     type_var_list = []
        
    #     for body in module.body:
    #         #print("\n")
    #         #print(body)
            

    #         if isinstance(body,ast.Assign):
    #             if isinstance(body.value, ast.Call):
    #                 assign_t = body.value.func.id

    #                 if assign_t == "struct":
    #                     #print(f"struct {''}: {body.value}")
    #                     type_var_list.append(json.dumps({
    #                         "type:": "struct",
    #                         "type_name": body.targets[0].id,
    #                         "args": [{"key": key.arg, "type": key.value.id} for key in body.value.keywords]
    #                     }))
            
    #         if isinstance(body,ast.ClassDef):
    #             bases = [base.id for base in body.bases]
    #             if "codable" in bases:
    #                 pass
    #                 #custom_structs.append()
    #             else:
    #                 wrap_class = PyWrapClass()
    #                 js = wrap_class.parse_code_json(body)
    #                 #wrap_class.parse_code(class_body)
    #                 #wrap_class.setup_callback_type()
    #                 wrap_list.append(js)
            
    #         #print("\n")
    #     #print(type_var_list)
    #     wrap_module = {
    #         "filename": wrap_title,
    #         "classes": wrap_list,
    #         "typevars": type_var_list,
    #         "custom_structs": custom_structs
    #     }

       
    #     # with open("./class_export.json", "w") as f:
    #     #     json.dump(wrap_module, f)
    #     return json.dumps(wrap_module)


        
        
    

    def parse_code_json(self,class_body):
        functions = []
        self.export_dict = {
            "title": class_body.name,
            "functions": functions,
            "decorators": [],
            "properties": self.properties
        }
        self.calltitle = class_body.name
        
        self.handle_class_decorators(class_body)
        #self.gen_send_start_function(send_functions)
        self.handle_class_children(class_body.body)

        return self.export_dict

    def handle_class_decorators(self,class_body: ast.ClassDef):
        
        def get_key(key: str, keywords: list[ast.keyword]) -> ast.keyword:
            for word in keywords:
                if word.arg == key:
                    return word
        
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
            elif id == "wrapper":
                if isinstance(dec, ast.Call):
                    keywords: list[ast.keyword] = dec.keywords
                    keywords_str = [word.arg for word in keywords]
                    dispatch_events = []
                    for word in keywords:
                        key = word.arg
                        word_value = word.value
                        # if isinstance(word_value, ast.Constant):
                        #     print(f"\tconstant {word_value.__dict__}")
                        # if isinstance(word_value, ast.List):
                        #     print(f"\tlist {word_value.__dict__}")
                        if key == "dispatch_events":
                            events = get_key("events", keywords)
                            if events:
                                _events_ = [event.value for event in events.value.elts]
                                d = {
                                    "type": "EventDispatch",
                                    "args": [json.dumps({
                                        "events": _events_
                                    })]
                                }
                                self.export_dict["decorators"].append(d)
                                #print(f"events: {[event.value for event in events.value.elts]}")
                                # events: ast.List = dec.args[0]
                                #_events_ = [event.value for event in events.elts]
                                #_events_ = [event.__dict__ for event in word_value.elts]
                                #print(f"\t{key} - {_events_}")


    def handle_class_children(self,child):
        for cbody in child:
            #print(type(cbody))
            if isinstance(cbody, ast.Assign):
                self.handle_class_properties(cbody)
            if isinstance(cbody,ast.FunctionDef):
                self.handle_class_function(cbody)
                
    def handle_class_properties(self, body: ast.Assign):

        t = body.value.func.id
        
        if t == "Property":
            self.properties.append(
                {
                    "name": body.targets[0].id,
                    "property_type": "Property",
                    "arg_type":  {
                        "name": "value",
                        "type": body.value.args[0].id,
                        "idx": 0,
                                    
                    }
                    
                }
            )    
        elif t == "StringProperty":
            
            self.properties.append(
                {
                    "name": body.targets[0].id,
                    "property_type": "StringProperty",
                    "arg_type":  {
                        "name": "value",
                        "type": "str",
                        "idx": 0,
                                    
                    }
                    
                }
            )    
    def handle_callback_decorator(self, dec: object, func_dict: dict, options: list[str]):
        #print("handle_callback_decorator")
        #print(dec.func.id)
        #print(dec.__dict__)
        keywords: list[ast.keyword] = dec.keywords
        for word in keywords:
            key = word.arg
            value = word.value.value
            #print(key.arg,key.value.value)
            #print(key.__dict__)
            if key == "direct":
                #func_dict["direct"] = True
                options.append("direct")
            else:
                func_dict[key] = value
            
    def handle_function_decorators(self, body: FunctionDef, func_dict: dict) -> List[str]:
        dec_list = []
        options = []
        for decorator in body.decorator_list:
            
            if isinstance(decorator,ast.Call):
                t = decorator.func.id
                if t == "callback":
                    self.handle_callback_decorator(decorator, func_dict, options)
                    
            else:
                t = decorator.id
            
            if t == "callback":
                #func_dict["is_callback"] = True
                options.append("callback")
            
            elif t == "send_self":
                options.append("send_self")

            elif t == "swift_func":
                #func_dict["swift_func"] = True
                options.append("swift_func")
            
            elif t == "call_target":
                func_dict["call_target"] = decorator.args[0].value
            
            elif t == "call_class":
                func_dict["call_class"] = decorator.args[0].value
            
            elif t == "call_object":
                func_dict["call_object"] = decorator.args[0].id
            
            elif t == "direct":
                #func_dict["direct"] = True
                options.append("direct")
        func_dict["options"] = options
       
    
    

    def handle_class_function(self, body: ast.FunctionDef):
        #print("function: ",body.name)
        func_args = body.args.args
        functions: list = self.export_dict["functions"]
        arg_list = []
        returns = body.returns
        
        singleton = False


        if returns:
            _return_ = handle_arg_type(returns, 0, True)
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

        if (not singleton and "callback" in func["options"]) or "send_self" in func["options"]:
            arg_list.append(
                {
                    "name": "cls",
                    "type": "CythonClass",
                    # "is_list": is_list,
                    # "is_data": is_data,
                    "options": [],
                    "idx": count
                }
            )
            count += 1
        for arg in func_args:
            #print("\t",arg.arg, arg.annotation.id)
            if arg.arg == "self":
                continue
            arg_data = handle_arg_type(arg,count,False)
            #print("\t",arg_data)
            arg_list.append(arg_data)
            count += 1



class PyWrapModule:
    filename: str
    pyi_mode: bool
    classes: list[dict]
    custom_structs: list[dict]
    custom_enums: list[dict]
    python_classes: list[str]
    

    def __init__(self, wrap_title: str, string:str, pyi_mode: bool = False) -> str:
        self.classes = []
        self.custom_structs = []
        self.filename = wrap_title
        self.pyi_mode = pyi_mode
        self.python_classes = []
        module = ast.parse(string)
        wrap_list = []
        custom_structs = []
        self.custom_enums = []
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
                    elif assign_t == "Enum":
                        enum_keys = []

                        #enum_count = 0
                        for i, key in enumerate(body.value.args):
                            if isinstance(key, ast.Constant):
                                enum_keys.append({"key": key.value, "value": i})
                                
                        
                        for key in body.value.keywords:
                            enum_keys.append({"key": key.arg, "value": key.value.value})
                        self.custom_enums.append({
                            "type": "int",
                            "title": body.targets[0].id,
                            "keys": enum_keys
                        })
            
            if isinstance(body,ast.ClassDef):
                bases = [base.id for base in body.bases]
                deco_list = get_class_decorators(body.decorator_list)
                if "Codable" in bases:
                    self.handleCustomClasses(body, bases)
                    #custom_structs.append()
                elif "wrapper" in deco_list or self.pyi_mode:
                    
                    #else:
                    wrap_class = PyWrapClass()
                    js = wrap_class.parse_code_json(body)
                    #wrap_class.parse_code(class_body)
                    #wrap_class.setup_callback_type()
                    self.classes.append(js)
        
        py_src = extract_python_classes(string)
        
        self.python_classes.append(py_src)        

        # wrap_module = {
        #     "filename": wrap_title,
        #     "classes": wrap_list,
        #     "typevars": type_var_list,
        #     "custom_structs": custom_structs
        # }

       
        # # with open("./class_export.json", "w") as f:
        # #     json.dump(wrap_module, f)
        # return json.dumps(wrap_module)
    
    
    def export(self) -> str:
        return json.dumps(self.__dict__)
    
    def handleCustomEnums(self, cbody: ast.ClassDef, bases: list[str]):
        if "str" in bases:
            d = {
                "title": cbody.name
                
            }
    
    def handleCustomClasses(self, cbody: ast.ClassDef, bases: list[str]):
        assigns: list[dict] = []
        d = {
            "title": cbody.name,
            "sub_classes": bases,
            "assigns": assigns
        }
        for i, body in enumerate(cbody.body):
            if isinstance(body, ast.AnnAssign):
                value = body.value
                assigns.append(handle_arg_type(body, i, self.pyi_mode))
                
        
        self.custom_structs.append(d)
        
        