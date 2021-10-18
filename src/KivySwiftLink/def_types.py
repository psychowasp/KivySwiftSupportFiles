list_unwrapper = "[{arg}[x] for x in range({arg}_size)]"
list_upwrapper_special = "[{sarg}[x] for x in range({arg}_size)]"
bytes_unwrapper = "{arg}[:{arg}_size]"
str_enc = "{arg}.encode('utf-8')"
str_dec = "{arg}.decode('utf-8')"

def_types = [
    {
        "type": "PythonCallback",
        "cython": "PythonCallback",
        "objc": "PythonCallback _Nonnull",
        "python": "PythonCallback",
        "size": 0,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": None,
    },
    {
        "type": "str",
        "cython": "PythonString",
        "objc": "PythonString _Nonnull",
        "python": "str",
        "size": 1,
        "send_arg": str_enc,
        "call_arg": str_dec,
        "list_send_arg": None,
        "list_call_arg": "[{arg}[x].decode('utf8') for x in range({arg}_size)]"
    },
    {
        "type": "bytes",
        "cython": "PythonBytes",
        "objc": "PythonBytes _Nonnull",
        "python": "bytes",
        "size": 1,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": None
    },
    {
        "type": "json",
        "cython": "PythonJsonString",
        "objc": "PythonJsonString _Nonnull",
        "python": "object",
        "size": 1,
        "send_arg": "json.dumps({arg}).encode('utf-8')",
        "call_arg": "json.loads({arg})",
        "list_send_arg": None,
        "list_call_arg": None
    },
    {
        "type": "jsondata",
        "cython": "PythonJsonData",
        "objc": "PythonJsonData _Nonnull",
        "python": "object",
        "size": 1,
        "send_arg": "json.dumps({arg}).encode('utf-8')",
        "call_arg": "json.loads({arg}[:{arg}_size])",
        "list_send_arg": None,
        "list_call_arg": None
    },
    {
        "type": "object",
        "cython": "PythonObject",
        "objc": "PythonObject _Nonnull",
        "python": "object",
        "size": 8,
        "send_arg": "<PythonObject>{arg}",
        "call_arg": "<object>{arg}",
        "list_send_arg": None,
        "list_call_arg": "[<object>{arg}[x] for x in range({arg}_size)]"
    },
    {
        "type": "bool",
        "cython": "bint",
        "objc": "BOOL",
        "python": "bool",
        "size": 1,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "data",
        "cython": "const unsigned char*",
        "objc": "const unsigned char* _Nonnull",
        "python": "bytes",
        "size": 1,
        "send_arg": None,
        "call_arg": "<bytes>{arg}[0:{arg}_size]",
        "list_send_arg": None,
        "list_call_arg": "{arg}[:{arg}_size]"
    },
    ### Integer Types ###
    {
        "type": "byte",
        "cython": "char",
        "objc": "char",
        "python": "byte",
        "size": 1,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "int8",
        "cython": "char",
        "objc": "char",
        "python": "int",
        "size": 1,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "ubyte",
        "cython": "unsigned char",
        "objc": "unsigned char",
        "python": "byte",
        "size": 1,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "uint8",
        "cython": "unsigned char",
        "objc": "unsigned char",
        "python": "int",
        "size": 1,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "short",
        "cython": "short",
        "objc": "short",
        "python": "int",
        "size": 2,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "int16",
        "cython": "short",
        "objc": "short",
        "python": "int",
        "size": 2,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "ushort",
        "cython": "unsigned short",
        "objc": "unsigned short",
        "python": "int",
        "size": 2,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "uint16",
        "cython": "unsigned short",
        "objc": "unsigned short",
        "python": "int",
        "size": 2,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "int32",
        "cython": "int",
        "objc": "int",
        "python": "int",
        "size": 4,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "uint32",
        "cython": "unsigned int",
        "objc": "unsigned int",
        "python": "int",
        "size": 4,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "int", #Int 64
        "cython": "long",
        "objc": "long",
        "python": "int",
        "size": 8,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "long",
        "cython": "long",
        "objc": "long",
        "python": "int",
        "size": 8,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "uint", #unsigned int64
        "cython": "unsigned long",
        "objc": "unsigned long",
        "python": "int",
        "size": 8,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "ulong",
        "cython": "unsigned long",
        "objc": "unsigned long",
        "python": "int",
        "size": 8,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },

    ### Floating-Point Types ###
    {
        "type": "float", #double
        "cython": "double",
        "objc": "double",
        "python": "float",
        "size": 8,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "float32",
        "cython": "float",
        "objc": "float",
        "python": "float",
        "size": 4,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "double",
        "cython": "double",
        "objc": "double",
        "python": "float",
        "size": 8,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },
    {
        "type": "ldouble",
        "cython": "long double",
        "objc": "long double",
        "python": "float",
        "size": 10,
        "send_arg": None,
        "call_arg": None,
        "list_send_arg": None,
        "list_call_arg": list_unwrapper
    },

]
from KivySwiftLink.typedef_generator import GetSwiftTypes
def types2dict(t: str, is_list=False, objc=False) -> dict:
    rtn = {}
    
    if objc:
        end_string = " _Nonnull"
    else:
        end_string = ""
    for d in def_types:
        _type = d['type']
        if t in ("call_arg","send_arg","list_call_arg","list_send_arg"):
            arg = d[t]
            if arg:
                rtn[_type] = arg
            else:
                rtn[_type] = "{arg}"
        else:
            if is_list:
                list_type = d[t]
                #rtn[_type] = f"const {list_type}*{end_string}"
                rtn[_type] = f"PythonList_{GetSwiftTypes(_type)} {end_string}"
            else:
                rtn[_type] = d[t]
    if t == "send_arg":
        rtn[""] = "{arg}"
    return rtn

##### old ####
# def types2dict(t: str, is_list=False, objc=False) -> dict:
#     rtn = {}
    
#     if objc:
#         end_string = " _Nonnull"
#     else:
#         end_string = ""
#     for d in def_types:
#         _type = d['type']
#         if t in ("call_arg","send_arg","list_call_arg","list_send_arg"):
#             arg = d[t]
#             if arg:
#                 rtn[_type] = arg
#             else:
#                 rtn[_type] = "{arg}"
#         else:
#             if is_list:
#                 list_type = d[t]
#                 rtn[_type] = f"const {list_type}*{end_string}"
#             else:
#                 rtn[_type] = d[t]
#     if t == "send_arg":
#         rtn[""] = "{arg}"
#     return rtn