from ctypes import c_double, c_float, c_int, c_int16, c_long, c_longdouble, c_longlong, c_short, c_uint16, c_ulong, c_ulonglong
from ctypes import c_uint8, c_uint32
from ctypes import c_uint8
from ctypes import c_int8 
from ctypes import c_uint
from ctypes import c_long
from typing import List,Tuple,TypeVar
from cython import struct
from enum import Enum
from collections.abc import Sequence as sequence
#from ctypes import c_int8 as


__all__ = [
    "long",
    "ulong",
    "longlong",
    "ulonglong",
    "uint8",
    "int16",
    "uint16",
    "int32",
    "uint32",
    "data",
    "json",
    "jsondata",
    "uint",
    "double",
    "float32",
    ## other types
    "TypeVar",
    "struct",
    "List",
    "Tuple",
    "callback",
    "call_class",
    "call_target",
    "swift_func",
    "EventDispatcher",
    "Codable",
    "direct",
    "wrapper",
    "python",
    "Enum",
    "send_self",
    "sequence",
    "ObjectStrEnum",
    "ObjectIntEnum"
    ]

int32 = c_int
uint32 = c_uint32
long = c_long
ulong = c_ulong
longlong = c_longlong
ulonglong = c_ulonglong
uint8 = c_uint8
short = c_int16
int16 = c_int16
ushort = c_uint16
uint16 = c_uint16
data = c_uint8
json = c_int8
jsondata = c_uint8
uint = c_uint
double = c_double
float32 = c_float
longdouble = c_longdouble


def EventDispatcher(_: list[str]): ...

def callback(direct: bool): ...

def call_class(class_name: str): ...

def call_target(class_name: str): ...

def swift_func(): ...

def _direct(): ...

#def codable(): ...

class Codable: ...

#def wrapper(dispatch_events: bool = False, events: list[str] = [], singleton: bool = True): ...

class wrapper:
    
    def __init__(self, *args, **kwargs): ...
    
    def __call__(self, *args, **kwargs): ...

def python(): ...


def send_self(): ...

ObjectStrEnum = Enum

ObjectIntEnum = Enum

direct = _direct()