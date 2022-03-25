import ast
from ast import *
from os import remove
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


wrap_module_shared = None

def handle_imports(body: ast.ImportFrom):
    print(body.module.__dict__)
    
def handle_wrapped_class(class_body: ast.ClassDef, d: dict, pyi_mode: bool):
    for cbody in class_body.body:
        # if "callback" in dec_list:
        #     #class_body.body.remove(cbody)
        #     cbody_del_list.append(cbody)
        # else:
        match cbody:
            case ast.Assign():
                pass
            case ast.AnnAssign():
                pass
            case ast.Expr():
                pass
            
            case ast.FunctionDef():
                

        # if isinstance(cbody, ast.Assign):
        #     pass
        # elif isinstance(cbody, ast.AnnAssign):
        #     pass
        # elif isinstance(cbody, ast.Expr):
        #     pass
        # else:
        #     cbody: ast.FunctionDef
                for arg in cbody.args.args:
                    if isinstance(arg, ast.arg):
                        anno = arg.annotation
                    else:
                        anno = arg
                    if isinstance(anno, ast.Subscript):
                        _anno_ = anno
                        match _anno_:
                            case "list" | "sequence":
                                t = _anno_.slice.id
                                if t in d:
                                    _anno_.slice.id = d[t]
                                else:
                                    _anno_.slice.id = t
                            case "tuple":        
                                t = _anno_.value.id
                            
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
        
def parse_helper(string: str, d: dict, extra: str = "", sphinx_mode = False):
    module = ast.parse(string)
    body_list = module.body
    excluded_classes = [] 
    remove_stuff = []
    for class_body in body_list:
        
        match class_body:
            case ast.Import():...
                #exit(0)
            case ast.ImportFrom():...
                #remove_stuff.append(class_body)
            case ast.ClassDef():
                class_body.decorator_list.clear()
                # for dec in class_body.decorator_list:
                class_body.body
                #     remove_stuff.append(dec)
                bases = [base.id for base in class_body.bases]
                if "Codable" in bases:
                    pass
                else:
                #cbody_del_list = []
                    handle_wrapped_class(class_body, d, False)
                
            case ast.Assign:
                handleGlobalAssigns(module,class_body)
        # if isinstance(class_body,ast.ClassDef):
        #     #class_list = class_body.body
            
        #     bases = [base.id for base in class_body.bases]
        #     if "Codable" in bases:
        #         pass
        #     else:
        #     #cbody_del_list = []
        #         handle_wrapped_class(class_body, d, False)
                
                
        #         # for rem_body in cbody_del_list:
        #         #     class_body.body.remove(rem_body)
        # elif isinstance(class_body, ast.Assign):
        #     handleGlobalAssigns(module,class_body)
    for c in remove_stuff:
        module.body.remove(c)
            
    add_enums(module, extra)
    src = astor.to_source(module)
    return src

def add_enums(module: ast.Module, extra: str):
    mod = ast.parse(extra)
    for i, body in enumerate(mod.body):
        module.body.insert(i, body)
        

def handleGlobalAssigns(module:ast.Module, body: ast.Assign):
    value = body.value
    #print("handleGlobalAssigns:")
    if isinstance(value, ast.Call):
        func = value.func
        id = func.id
        #print(f"\tid: {func.id} {func}")
        #print(f"\tfunc: {value.func}")
        #print(f"\targs: {value.args}")
        #print(f"\tkeywords: {value.keywords}")
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

def remove_class_decorator(module: ast.Module,i, body_list: list[ast.stmt], key: str):
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
        module.body[i].decorator_list.remove(target)
        #cbody.decorator_list.remove(target)
        #cbody.remove(target)
        #body_list.remove(target)
    #exit(0)

def extract_python_classes(string: str) -> str:
    module = ast.parse(string)
    body_list = module.body
    excluded_classes = [] 
    for i, class_body in enumerate(body_list):
        if isinstance(class_body,ast.ClassDef):
            deco_list = get_class_decorators(class_body.decorator_list)
            
            if "python" in deco_list:
                
                remove_class_decorator(module,i,class_body.decorator_list,"python")
                #remove_class_decorator(class_body.decorator_list,"python")
                continue
            if "wrapper" in deco_list:
                remove_class_decorator(module,i,class_body.decorator_list,"wrapper")
                #continue
            
            excluded_classes.append(class_body)
    
    for imp in body_list:
        if isinstance(imp, ast.ImportFrom):
            if imp.module == "swift_types":
                body_list.remove(imp)
    excluded_assigns = []
    for assign in body_list:
        if isinstance(assign, ast.Assign):
            if isinstance(assign.value, ast.Call):
                if assign.value.func.id == "Enum":
                    excluded_assigns.append(assign)
                    #body_list.remove(assign)
                elif assign.value.func.id == "ObjectStrEnum":
                    excluded_assigns.append(assign)
                    #body_list.remove(assign)
    for ann in excluded_assigns:
        module.body.remove(ann)
    for cls in excluded_classes:
        module.body.remove(cls)

    src = astor.to_source(module)
    return src
    

def handle_arg_arg(arg: ast.arg, options: list[str]) -> str:
    anno = arg.annotation
    #print(PRINTTAB, type(arg.annotation))
    match anno:
        case ast.Name():
            return anno.id
        case ast.Subscript():
            return handleSubscript(anno, options)
    # if isinstance(anno, ast.Name):
    #     #options.append("py_object")
    #     return anno.id
    # elif isinstance(anno, ast.Subscript):
    #     return handleSubscript(anno, options)

def handleSubscript(arg: ast.Subscript, options: list[str]) -> str:
    sub_id: str = arg.value.id
    match sub_id:
        case "list":
            options.append("list")
            return arg.slice.id
        case "sequence":
            options.append("sequence")
            options.append("py_object")
            return arg.slice.id
        case "tuple":
            options.append("tuple")
            return sub_id
        case "array":
            options.append("array")
            return arg.slice.id
        case "object":
            options.append("py_object")
            return arg.slice.id
        case "memoryview":
            options.append("memoryview")
            return arg.slice.id
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
    t = "void"
    match arg:
        case ast.arg():
            t = handle_arg_arg(arg, options)
        case ast.AnnAssign():
            t = handle_AnnAssign(arg,options)
        case ast.Subscript():
            print("ast.Subscript")
            t = handleSubscript(arg, options)
        case ast.Slice():
            print("ast.Slice")
        case ast.Name():
            t = arg.id
            
            
    # if isinstance(arg, ast.arg):
    #     #print("ast.arg")
    #     t = handle_arg_arg(arg, options)
    # elif isinstance(arg, ast.AnnAssign):
    #     #print("ast.AnnAssign")
    #     t = handle_AnnAssign(arg,options)
    # elif isinstance(arg, ast.Subscript):
    #     print("ast.Subscript")
    # elif isinstance(arg, ast.Slice):
    #     print("ast.Slice")
    # elif isinstance(arg, ast.Name):
    #     t = arg.id
    # else:
    #     t = ""
    
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
        print("return",t)
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
    singleton: bool
    functions: list[dict]
    
    def __init__(self, pyi_mode: bool = False):
        self.properties = []
        self.pyi_mode = pyi_mode
        self.singleton = True
        self.functions = []
    

    def parse_code_json(self,class_body):
        #functions = []
        self.export_dict = {
            "title": class_body.name,
            "functions": self.functions,
            "decorators": [],
            "properties": self.properties,
            
        }
        self.calltitle = class_body.name
        
        self.handle_class_decorators(class_body)
        #self.gen_send_start_function(send_functions)
        self.handle_class_children(class_body.body)
    
        self.export_dict["singleton"] = self.singleton
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
            match id:
                case "EventDispatcher":
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
                case "wrapper":
                    match dec:
                        case ast.Call():
                            keywords: list[ast.keyword] = dec.keywords
                            keywords_str = [word.arg for word in keywords]
                            dispatch_events = []
                            for word in keywords:
                                key = word.arg
                                word_value = word.value
                                
                                match key:
                                    case "dispatch_events":
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
                                    case "sequences_as_object": ...
                                    case "str_as_object": ...
                                    
                                    case "singleton":
                                        svalue = word.value
                                        #if isinstance(svalue, ast.Constant):
                                        self.singleton = svalue.value
                        
                
            # if id == "EventDispatcher":
            #     if len(dec.args) != 0:
            #         events: ast.List = dec.args[0]
            #         _events_ = [event.value for event in events.elts]
            #         d = {
            #             "type": "EventDispatch",
            #             "args": [json.dumps({
            #                 "events": _events_
            #                 })]
                        
            #         }
            #         self.export_dict["decorators"].append(d)
            # elif id == "wrapper":
            #     if isinstance(dec, ast.Call):
            #         keywords: list[ast.keyword] = dec.keywords
            #         keywords_str = [word.arg for word in keywords]
            #         dispatch_events = []
            #         for word in keywords:
            #             key = word.arg
            #             word_value = word.value
            #             # if isinstance(word_value, ast.Constant):
            #             #     print(f"\tconstant {word_value.__dict__}")
            #             # if isinstance(word_value, ast.List):
            #             #     print(f"\tlist {word_value.__dict__}")
            #             if key == "dispatch_events":
            #                 events = get_key("events", keywords)
            #                 if events:
            #                     _events_ = [event.value for event in events.value.elts]
            #                     d = {
            #                         "type": "EventDispatch",
            #                         "args": [json.dumps({
            #                             "events": _events_
            #                         })]
            #                     }
            #                     self.export_dict["decorators"].append(d)
            #                     #print(f"events: {[event.value for event in events.value.elts]}")
            #                     # events: ast.List = dec.args[0]
            #                     #_events_ = [event.value for event in events.elts]
            #                     #_events_ = [event.__dict__ for event in word_value.elts]
            #                     #print(f"\t{key} - {_events_}")
            #             elif key == "sequences_as_object":
            #                 ...
                        
                        
            #             elif key == "str_as_object":
            #                 ...


    def handle_class_children(self,child):
        functions = self.export_dict["functions"]
        for cbody in child:
            #print(type(cbody))
            match cbody:
                case ast.Assign():
                    self.handle_class_properties(cbody)
                case ast.FunctionDef():
                    self.handle_class_function(cbody)
                case ast.ClassDef():
                    name = cbody.name
                    match name:
                        case "Callbacks":
                            print("ast.ClassDef")
                            print(cbody.__dict__)
                            for fbody in cbody.body:
                                if isinstance(fbody, ast.FunctionDef):
                                    self.handle_callbacks(fbody)
                
    def handle_class_properties(self, body: ast.Assign):

        t = body.value.func.id
        match t:
            case "Property":
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
            case "StringProperty":
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
        keywords: list[ast.keyword] = dec.keywords
        for word in keywords:
            key = word.arg
            value = word.value.value

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
            match t:
                case "callback":
                    options.append("callback")
                case "send_self":
                    options.append("send_self")
                case "swift_func":
                    options.append("swift_func")
                case "call_target":
                    func_dict["call_target"] = decorator.args[0].value
                case "call_class":
                    func_dict["call_class"] = decorator.args[0].value
                case "call_object":
                    func_dict["call_object"] = decorator.args[0].value
                case "direct":
                    options.append("direct")
        if "options" in func_dict:
            func_dict["options"].extend(options)
            return
        
        func_dict["options"] = options
        
    def handle_callbacks(self, body: ast.FunctionDef):
        func_args = body.args.args
        functions: list = self.functions
        arg_list = []
        returns = body.returns
        if returns:
            _return_ = handle_arg_type(returns, 0, True)
        else:
            _return_ = {
            "name": "void",
            "type": "void",
            "idx": 0,
            "is_return": True,
        }
        func = {
            "name": body.name,
            "args": arg_list,
            "returns": _return_,
            "options": ["callback"]
        }
        count = 0
        for arg in func_args:
            if arg.arg == "self":
                continue
            arg_data = handle_arg_type(arg,count,False)
            arg_list.append(arg_data)
            count += 1
        
        
        self.handle_function_decorators(body,func)
        functions.append(func)
        
    
    def handle_class_function(self, body: ast.FunctionDef):
        #print("function: ",body.name)
        func_args = body.args.args
        functions: list = self.functions
        arg_list = []
        returns = body.returns
        
        singleton = self.singleton


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
        func_options = func["options"]
        if not singleton:
            if "callback" in func_options:
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
        if "send_self" in func_options:
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
        # if (not singleton and "callback" in func["options"]) or "send_self" in func["options"]:
        #     arg_list.append(
        #         {
        #             "name": "cls",
        #             "type": "CythonClass",
        #             # "is_list": is_list,
        #             # "is_data": is_data,
        #             "options": [],
        #             "idx": count
        #         }
        #     )
        #     count += 1
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
        wrap_module_shared = self
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
        
        self.handleCustomEnums(module.body)
        
        for body in module.body:
            match body:
                case ast.ClassDef():
                    bases = [base.id for base in body.bases]
                    deco_list = get_class_decorators(body.decorator_list)
                    if "Codable" in bases:
                        self.handleCustomClasses(body, bases)
                        #custom_structs.append()
                    elif "wrapper" in deco_list or self.pyi_mode:
                        wrap_class = PyWrapClass()
                        js = wrap_class.parse_code_json(body)
                        self.classes.append(js)
        py_src = extract_python_classes(string)
        
        self.python_classes.append(py_src)                   

    
    def export(self) -> str:
        return json.dumps(self.__dict__)
    
    def handleCustomEnums(self, mbody: ast.Module):
        for body in mbody:
            match body:
                case ast.Assign():
                    match body.value:
                        case ast.Call():
                            match body.value.func.id:
                                # case "struct":
                                #     type_var_list.append(json.dumps({
                                #         "type:": "struct",
                                #         "type_name": body.targets[0].id,
                                #         "args": [{"key": key.arg, "type": key.value.id} for key in body.value.keywords]
                                #     }))
                                case "Enum":
                                    enum_keys = []
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
                                case "ObjectStrEnum":
                                    print("\n\n\n\nObjectEnum Found\n\n\n\n")
                                    enum_keys = []
                                    for i, key in enumerate(body.value.args):
                                        if isinstance(key, ast.Constant):
                                            enum_keys.append({"key": key.value, "value": i})    
                                    for key in body.value.keywords:
                                        enum_keys.append({"key": key.arg, "value": key.value.value})
                                    self.custom_enums.append({
                                        "type": "object",
                                        "subtype": "str",
                                        "title": body.targets[0].id,
                                        "keys": enum_keys
                                    })

    
    
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
        
        