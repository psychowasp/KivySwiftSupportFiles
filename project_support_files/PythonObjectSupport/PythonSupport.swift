//
//  PythonSupport.swift
//  metacam
//
//  Created by MusicMaker on 23/02/2022.
//

import Foundation
import CoreGraphics


extension String {
    var python_str: PythonPointer { PyUnicode_FromString(self) }
    @inlinable var py_object: PythonPointer { PyUnicode_FromString(self) }
}
extension Data {
    var python_str_utf8: PythonPointer { PyUnicode_FromString(String.init(data: self, encoding: .utf8)) }
    var python_str_utf16: PythonPointer { PyUnicode_FromString(String.init(data: self, encoding: .utf16)) }
    var python_str_utf32: PythonPointer { PyUnicode_FromString(String.init(data: self, encoding: .utf32)) }
    var python_str_unicode: PythonPointer { PyUnicode_FromString(String.init(data: self, encoding: .unicode)) }
    public var pythonList: PythonPointer {
        let list = PyList_New(0)
        for element in self {
            PyList_Append(list, PyLong_FromUnsignedLong(UInt(element)))
        }
        return list
    }
        
    public var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, PyLong_FromUnsignedLong(UInt(element)))
        }
        return tuple
    }
}



extension SignedInteger {
    var python_int: PythonPointer {PyLong_FromLong(Int(self)) }
    var python_str: PythonPointer { PyUnicode_FromString(String(self)) }
}

extension UnsignedInteger {
    var python_int: PythonPointer { PyLong_FromUnsignedLong(UInt(self)) }
    var python_str: PythonPointer { PyUnicode_FromString(String(self)) }
}

extension Int {
    var python_int: PythonPointer { PyLong_FromLong(self) }
    var python_str: PythonPointer { PyUnicode_FromString(String(self)) }
}

extension UInt {
    var python_int: PythonPointer { PyLong_FromUnsignedLong(self) }
    var python_str: PythonPointer { PyUnicode_FromString(String(self)) }

}

extension Double {
    var python_float: PythonPointer { PyFloat_FromDouble(self) }
    var python_str: PythonPointer { PyUnicode_FromString(String(self)) }
}

extension Float {
    var python_float: PythonPointer { PyFloat_FromDouble(Double(self)) }
    var python_str: PythonPointer { PyUnicode_FromString(String(self)) }
}

@available(iOS 14, *)
extension Float16 {
    var python_float: PythonPointer { PyFloat_FromDouble(Double(self)) }
    var python_str: PythonPointer { PyUnicode_FromString(String(self)) }
}

extension CGFloat {
    var python_float: PythonPointer { PyFloat_FromDouble(self) }
    var python_str: PythonPointer { PyUnicode_FromString("\(self)") }
}


extension Array where Element == PythonPointer {
    
    
    
    public var pythonList: PythonPointer {
        let list = PyList_New(0)
        for element in self {
            PyList_Append(list, element)
        }
        return list
    }
    
    var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, element)
        }
        return tuple
    }
}

extension Array where Element == String {
    public var pythonList: PythonPointer {
        let list = PyList_New(0)
        for element in self {
            PyList_Append(list, PyUnicode_FromString(element))
        }
        return list
    }
    
    var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, PyUnicode_FromString(element))
        }
        return tuple
    }
}

extension Array where Element == Double {
    public var pythonList: PythonPointer {
        let list = PyList_New(0)
        for element in self {
            PyList_Append(list, PyFloat_FromDouble(element))
        }
        return list
    }
    
    var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, PyFloat_FromDouble(element))
        }
        return tuple
    }
}


extension Array where Element: SignedInteger  {
    public var pythonList: PythonPointer {
        let list = PyList_New(0)
        for element in self {
            PyList_Append(list, PyLong_FromLong(Int(element)))
        }
        return list
    }
    
    var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, PyLong_FromLong(Int(element)))
        }
        return tuple
    }
}

extension Array where Element: UnsignedInteger {
    public var pythonList: PythonPointer {
        let list = PyList_New(0)
        for element in self {
            PyList_Append(list, PyLong_FromUnsignedLong(UInt(element)))
        }
        return list
    }
    
    var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, PyLong_FromUnsignedLong(UInt(element)))
        }
        return tuple
    }
}


extension Array where Element == Int {
    
    init(_ object: PythonPointer) {
        self.init()
        
    }
    
    public var pythonList: PythonPointer {
        let list = PyList_New(0)
        for element in self {
            PyList_Append(list, PyLong_FromLong(element))
        }
        return list
    }

    var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, PyLong_FromLong(element))
        }
        return tuple
    }
}

extension Array where Element == UInt {
    public var pythonList: PythonPointer {
        let list = PyList_New(0)
        for element in self {
            PyList_Append(list, PyLong_FromUnsignedLong(element))
        }
        return list
    }

    var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, PyLong_FromUnsignedLong(element))
        }
        return tuple
    }
}


extension UnsafeMutablePointer where Pointee == PythonPointer {
    var test: String {""}
}

extension Dictionary where Key == String, Value == String {
    
    var pythonDict: PythonPointer {
        let dict = PyDict_New()
        for (key, value) in self {
            PyDict_SetItem(dict, key.python_str, value.python_str)
        }
        
        return dict
    }
}






func test3434() {
    let array: [Int8] = [1,2,3,4,5,6,7,8,9,0]
    let list = array.pythonList
    list.decref()
    let array2: [Int] = [1,2,3,4,5,6,7,8,9,0]
    let tuple = array2.pythonTuple
    tuple.decref()
}
