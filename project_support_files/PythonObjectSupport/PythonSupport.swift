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
