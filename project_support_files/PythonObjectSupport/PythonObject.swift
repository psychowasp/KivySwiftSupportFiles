//
//  PythonObject_New.swift
//  metacam
//
//  Created by MusicMaker on 01/03/2022.
//

import Foundation


class PythonPointerAutoRelease {
    let ptr: PythonPointer
    private let keep: Bool
    
    init(pointer: PythonPointer, keep: Bool = true) {
        self.ptr = pointer
        self.keep = keep
        if keep {
            Py_IncRef(pointer)
        }
    }
    
    init(from_getattr pointer: PythonPointer) {
        ptr = pointer
        self.keep = true
    }
    
    deinit {
        if keep {
            Py_DecRef(ptr)
            //print("deinit \(ptr!) ref count is now \(ptr!.pointee.ob_refcnt)")
        }
    }
}



public class PythonObjectSlim {
    public let ptr: PythonPointer
    
    
    public init(pointer: PythonPointer?) {
        ptr = pointer!
        Py_IncRef(ptr)
    }
    
    deinit {
        Py_DecRef(ptr)
    }
    
    
}



@dynamicMemberLookup
public struct PythonObject {
    public let ptr: PythonPointer
    private let object_autorelease: PythonPointerAutoRelease
    
    public init(ptr: PythonPointer, keep_alive: Bool = false, from_getter: Bool = false) {
        //print("initing PythonObject",ptr as Any, ptr!.pointee.ob_refcnt)
        self.ptr = ptr
        self.object_autorelease = PythonPointerAutoRelease(pointer: ptr, keep: keep_alive)
    }
    
    subscript(dynamicMember member: String) -> PythonPointer {
        get {
            let obj: PythonPointer = PyObject_GetAttrString(ptr, member)
            Py_DecRef(ptr)
            return obj
        }
        set {
            PyObject_SetAttrString(ptr, member, newValue)
        }
    }

    
    
    subscript(dynamicMember member: String) -> PythonObject {
        get {
            PythonObject(ptr: PyObject_GetAttrString(ptr, member) , from_getter: true)
        }
        set {
            PyObject_SetAttrString(ptr, member, newValue.ptr)
        }
    }
    
  
    
    subscript(dynamicMember member: String) -> Int {
        get {
            let obj = PyObject_GetAttrString(ptr, member)
            Py_DecRef(obj)
            return PyLong_AsLong(obj)
        }
        set {
            let obj = PyLong_FromLong(newValue)
            PyObject_SetAttrString(ptr, member, obj)
            Py_DecRef(obj)
        }
    }
    
    
//    subscript(dynamicMember member: PythonPointer) -> PythonPointer {
//        get {
//            PyObject_GetAttr(ptr, member)
//        }
//        set {
//            PyObject_SetAttr(ptr, member, newValue)
//        }
//    }
    
//    subscript(dynamicMember member: PythonPointer) -> PythonPointer? {
//        get {
//            PyObject_GetAttr(ptr, member)
//        }
//        set {
//            PyObject_SetAttr(ptr, member, newValue)
//        }
//    }
//
//    subscript(dynamicMember member: PythonPointer?) -> PythonPointer {
//        get {
//            PyObject_GetAttr(ptr, member)
//        }
//        set {
//            PyObject_SetAttr(ptr, member, newValue)
//        }
//    }
//
//    subscript(dynamicMember member: PythonPointer?) -> PythonPointer? {
//        get {
//            PyObject_GetAttr(ptr, member)
//        }
//        set {
//            PyObject_SetAttr(ptr, member, newValue)
//        }
//    }
//
//    subscript(dynamicMember member: PythonObject) -> PythonPointer {
//        get {
//            PyObject_GetAttr(ptr, member.ptr)
//        }
//        set {
//            PyObject_SetAttr(ptr, member.ptr, newValue)
//        }
//    }
//
//    subscript(dynamicMember member: PythonObject) -> PythonPointer? {
//        get {
//            PyObject_GetAttr(ptr, member.ptr)
//        }
//        set {
//            PyObject_SetAttr(ptr, member.ptr, newValue)
//        }
//    }
    
//    subscript(dynamicMember member: PythonObject) -> PythonObject {
//        get {
//            PythonObject(ptr: PyObject_GetAttr(ptr, member.ptr))
//        }
//        set {
//            PyObject_SetAttr(ptr, member.ptr, newValue.ptr)
//        }
//    }
//
//    subscript(dynamicMember member: PythonPointer) -> PythonObject {
//        get {
//            PythonObject(ptr: PyObject_GetAttr(ptr, member))
//        }
//        set {
//            PyObject_SetAttr(ptr, member, newValue.ptr)
//        }
//    }
//
//    subscript(dynamicMember member: PythonPointer?) -> PythonObject {
//        get {
//            PythonObject(ptr: PyObject_GetAttr(ptr, member))
//        }
//        set {
//            PyObject_SetAttr(ptr, member, newValue.ptr)
//        }
//    }
}






extension PythonObject {
    
    @inlinable public var ref_count: Int { ptr!.pointee.ob_refcnt }
    
    @inlinable public var int: Int { PyLong_AsLong(ptr) }
    @inlinable public var uint: UInt { PyLong_AsUnsignedLong(ptr)}
    @inlinable public var int32: Int32 { Int32(clamping: PyLong_AsUnsignedLong(ptr)) }
    @inlinable public var uint32: UInt32 { UInt32(clamping: PyLong_AsUnsignedLong(ptr)) }
    @inlinable public var int16: Int16 { Int16(clamping: PyLong_AsUnsignedLong(ptr)) }
    @inlinable public var uint16: UInt16 { UInt16(clamping: PyLong_AsUnsignedLong(ptr)) }
    @inlinable public var short: Int16 { Int16(clamping: PyLong_AsUnsignedLong(ptr)) }
    @inlinable public var ushort: UInt16 { UInt16(clamping: PyLong_AsUnsignedLong(ptr)) }
    @inlinable public var int8: Int8 { Int8(clamping: PyLong_AsUnsignedLong(ptr)) }
    @inlinable public var uint8: UInt8 { UInt8(clamping: PyLong_AsUnsignedLong(ptr)) }
    @inlinable public var double: Double { PyFloat_AsDouble(ptr) }
    @inlinable public var float: Float { Float(PyFloat_AsDouble(ptr)) }
    @inlinable public var string: String { String.init(cString: PyUnicode_AsUTF8(ptr)) }
    
    
    
    
    @inlinable public var iterator: PythonPointer? { PyObject_GetIter(ptr) }
    
    @inlinable public var is_sequence: Bool { PySequence_Check(ptr) == 1 }
    @inlinable public var is_dict: Bool { PythonDict_Check(ptr) }
    @inlinable public var is_tuple: Bool { PythonTuple_Check(ptr)}
    @inlinable public var is_unicode: Bool { PythonUnicode_Check(ptr) }
    @inlinable public var is_int: Bool { PythonLong_Check(ptr) }
    @inlinable public var is_float: Bool {PythonBool_Check(ptr) }
    @inlinable public var is_iterator: Bool { PyIter_Check(ptr) == 1}
    @inlinable public var is_bytearray: Bool { PythonByteArray_Check(ptr) }
    @inlinable public var is_bytes: Bool { PythonBytes_Check(ptr) }
    
    @inlinable func decref() {
        Py_DecRef(ptr)
    }
    
    @inlinable
    public __consuming func array() -> [Self] {
        let fast_list = PySequence_Fast(ptr, "")
        let list_count = PythonSequence_Fast_GET_SIZE(fast_list)
        let fast_items = PythonSequence_Fast_ITEMS(fast_list)
        let buffer = UnsafeBufferPointer(start: fast_items, count: list_count)
        var array = [Self]()
        array.reserveCapacity(buffer.count)
        for element in buffer {
            array.append(Self(ptr: element!, keep_alive: true, from_getter: false))
        }
        Py_DecRef(fast_list)
        return array
    }
    
    
}

extension PythonPointer {
    
    
    var object: PythonObject { PythonObject(ptr: self) }
    
    @inlinable
    public __consuming func array() -> [PythonObject] {
        let fast_list = PySequence_Fast(self, "")
        let list_count = PythonSequence_Fast_GET_SIZE(fast_list)
        let fast_items = PythonSequence_Fast_ITEMS(fast_list)
        let buffer = UnsafeBufferPointer(start: fast_items, count: list_count)
        var array = [PythonObject]()
        array.reserveCapacity(buffer.count)
        for element in buffer {
            array.append(PythonObject(ptr: element!, keep_alive: true, from_getter: false))
        }
        Py_DecRef(fast_list)
        return array
    }
    
    @inlinable
    public __consuming func array() -> [PythonObjectSlim] {
        let fast_list = PySequence_Fast(self, "")
        let list_count = PythonSequence_Fast_GET_SIZE(fast_list)
        let fast_items = PythonSequence_Fast_ITEMS(fast_list)
        let buffer = UnsafeBufferPointer(start: fast_items, count: list_count)
        var array = [PythonObjectSlim]()
        array.reserveCapacity(buffer.count)
        for element in buffer {
            array.append(PythonObjectSlim(pointer: element))
        }
        Py_DecRef(fast_list)
        return array
    }
    
}
