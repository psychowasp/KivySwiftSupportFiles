from typing import *


CTYPES_DICT = {
    "int": "long",
    "long": "long",
    "ulong": "unsigned long",
    "uint": "unsigned long",
    "int32": "int",
    "uint32": "unsigned int",
    "int8": "char",
    "char": "char",
    #"short": "short",
    "uint8": "unsigned char",
    "uchar": "unsigned char",
    "ushort": "unsigned short",
    "int16": "short",
    "uint16": "unsigned short",
    "longlong": "long long",
    "ulonglong": "unsigned long long",
    "float": "double",
    "double": "double",
    "float32": "float",
    "object": "const void*",
    "data": "const unsigned char*",
}

SWIFT_TYPES = {
    "PythonCallback": "PythonCallback",

    "int": "Int",
    "long": "Int",
    "ulong": "UInt",
    "uint": "UInt",
    "int32": "Int32",
    "uint32": "UInt32",
    "int8": "Int8",
    "char": "Int8",
    "short": "Int16",
    "uint8": "UInt8",
    "uchar": "UInt8",
    "ushort": "UInt16",
    "int16": "Int16",
    "uint16": "UInt16",
    "longlong": "Int64",
    "ulonglong": "UInt64",
    "float": "Double",
    "double": "Double",
    "float32": "Float",
    "object": "PythonObject",
    "data": "PythonData",
    "bytes": "PythonBytes",
    
}

def GetSwiftTypes(key: str) -> str:
    if key in SWIFT_TYPES:
        return SWIFT_TYPES[key]
    return key

def gen_typedef(t: str, name: str, objc: bool = False):
    if objc:
        return f"typedef {t} {name};"
    return f"ctypedef {t} {name}"

TYPEDEF_DICT = {
    #"data": gen_typedef("","")
    "data": gen_typedef("const unsigned char*","PythonData",True),
    "str": gen_typedef("const char*", "PythonString", True),
    "bytes": gen_typedef("const char*", "PythonBytes", True),
    "object": gen_typedef("const void*", "PythonObject", True),
    "json": gen_typedef("const char*", "PythonJsonString", True),
    "jsondata": gen_typedef("const unsigned char*", "PythonJsonData", True),
}
CTYPEDEF_DICT = {
    #"data": gen_typedef("","")
    "data": gen_typedef("const unsigned char*","PythonData",False),
    "str": gen_typedef("const char*", "PythonString", False),
    "bytes": gen_typedef("const char*", "PythonBytes", False),
    "object": gen_typedef("const void*", "PythonObject", False),
    "json": gen_typedef("const char*", "PythonJsonString", False),
    "jsondata": gen_typedef("const unsigned char*", "PythonJsonData", False),
}

def add_list_types(t: str, kw: dict ,objc: bool = False):

    kw[f"list_{t}"] = gen_typedef(f"const {CTYPES_DICT[t]}*", f"PythonList_{SWIFT_TYPES[t]}", objc)


c_types = [
    "int",
    "uint",
    #"long",
    "int32",
    "uint32",
    #"ulong",
    "longlong",
    "ulonglong",
    "uint8",
    #"short",
    "int16",
    #"ushort",
    "uint16",
    "double",
    "float32",
    "object",
    "data",
    
]

def load_c_types() -> dict:
    kw = {**CTYPEDEF_DICT}

    for t in c_types:
        add_list_types(t,kw,False)
    return kw

def load_objc_types() -> dict:
    kw = {**TYPEDEF_DICT}

    for t in c_types:
        add_list_types(t,kw,True
        )
    return kw

if __name__ == '__main__':


    with open("./wrapper_typedefs.h", "w") as f:
        for key, val in load_objc_types().items():
            f.write(f"//{key}\n")
            f.write(f"{val}\n\n")

