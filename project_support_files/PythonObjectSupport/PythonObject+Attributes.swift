//
//  PythonPointer+Attributes.swift
//  metacam
//
//  Created by MusicMaker on 01/03/2022.
//

import Foundation


extension PythonPointer {
    
    
    @inlinable
    func getAttr(withNoDecRef key: PythonPointer, dec_ref: Bool = true) -> Int {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsLong(attr)
        if dec_ref { Py_DecRef(attr) }
        return value
    }
    
//    @inlinable
//    func getAttr(key: PythonPointer?, dec_ref: Bool = true) -> Int {
//        let attr = PyObject_GetAttr(self, key)
//        let value = PyLong_AsLong(attr)
//        if dec_ref { Py_DecRef(attr) }
//        return value
//    }
    
}

extension PythonObject {
    
//    @inlinable
//    func setAttr(key: String, value: PythonPointer?) {
//        PyObject_SetAttrString(ptr, key, value)
//    }
//
//    @inlinable
//    func setAttr(key: PythonPointer?, value: PythonPointer?) {
//        PyObject_SetAttr(ptr, key, value)
//    }
    
    @inlinable
    func setAttr(key: String, value: PythonObject) {
        PyObject_SetAttrString(ptr, key, value.ptr)
    }
    
    @inlinable
    func setAttr(key: PythonObject, value: PythonObject) {
        PyObject_SetAttr(ptr, key.ptr, value.ptr)
    }
    
    @inlinable
    func getAttr(key: String) -> PythonPointer? {
        PyObject_GetAttrString(ptr, key)
    }
    
    @inlinable
    func getAttr(key: PythonPointer) -> PythonPointer? {
        PyObject_GetAttr(ptr, key)
    }
    
    @inlinable
    func getAttr(key: String) -> PythonPointer {
        PyObject_GetAttrString(ptr, key)
    }
    
    @inlinable
    func getAttr(key: PythonPointer) -> PythonPointer {
        PyObject_GetAttr(ptr, key)
    }
    
//    @inlinable
//    func getAttr(key: PythonPointer?) -> PythonPointer {
//        PyObject_GetAttr(ptr, key)
//    }
//    
//    @inlinable
//    func getAttr(key: PythonPointer?) -> PythonPointer? {
//        PyObject_GetAttr(ptr, key)
//    }
    
    @inlinable
    func getAttr(key: String) -> PythonObject {
        PythonObject(ptr: PyObject_GetAttrString(ptr, key), from_getter: true)
        
    }
    
    @inlinable
    func getAttr(key: PythonPointer) -> PythonObject {
        PythonObject(ptr: PyObject_GetAttr(ptr, key), from_getter: true)
    }
    
    @inlinable
    func getAttr(key: PythonObject) -> PythonObject {
        PythonObject(ptr: PyObject_GetAttr(ptr, key.ptr), from_getter: true)
    }
    
    @inlinable
    func getAttr(key: PythonObject) -> PythonPointer {
        PyObject_GetAttr(ptr, key.ptr)
    }
    
    @inlinable
    func getAttr(key: PythonObject) -> PythonPointer? {
        PyObject_GetAttr(ptr, key.ptr)
    }
    
    

}



