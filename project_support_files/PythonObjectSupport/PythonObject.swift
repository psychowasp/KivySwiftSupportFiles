//
//  PythonObject_New.swift
//  metacam
//
//  Created by MusicMaker on 01/03/2022.
//

import Foundation

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


public struct PythonObject {
    public let ptr: PythonPointer
    private let object_autorelease: PythonPointerAutoRelease
    
    public init(ptr: PythonPointer, keep_alive: Bool = false, from_getter: Bool = false) {
        self.ptr = ptr
        self.object_autorelease = PythonPointerAutoRelease(pointer: ptr, keep: keep_alive, from_getattr: from_getter)
    }
}





extension PythonObject {
    
    @inlinable public var ref_count: Int { ptr.pointee.ob_refcnt }
    
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
