import Foundation
import CoreGraphics

extension PythonPointer: Sequence, IteratorProtocol {

    public typealias Element = PythonPointer
    public typealias Iterator = PythonPointer
    @inlinable
    public mutating func next() -> PythonPointer? {
        PyIter_Next(self)
    }
    
    @inlinable
        public func getBuffer() -> UnsafeBufferPointer<UnsafeMutablePointer<PyObject>?> {
            let fast_list = PySequence_Fast(self, "")
            let list_count = PythonSequence_Fast_GET_SIZE(fast_list)
            let fast_items = PythonSequence_Fast_ITEMS(fast_list)
            let buffer = PySequenceBuffer(start: fast_items, count: list_count)
            //buffer.makeIterator()
//            defer {
//                print("Dec Ref \(fast_list)")
            Py_DecRef(fast_list)
            return buffer
        }
    
}



extension PythonPointer {
    
    @inlinable var int: Int { PyLong_AsLong(self) }
    @inlinable var uint: UInt { PyLong_AsUnsignedLong(self)}
    @inlinable var int32: Int32 { Int32(clamping: PyLong_AsUnsignedLong(self)) }
    @inlinable var uint32: UInt32 { UInt32(clamping: PyLong_AsUnsignedLong(self)) }
    @inlinable var int16: Int16 { Int16(clamping: PyLong_AsUnsignedLong(self)) }
    @inlinable var uint16: UInt16 { UInt16(clamping: PyLong_AsUnsignedLong(self)) }
    @inlinable var short: Int16 { Int16(clamping: PyLong_AsUnsignedLong(self)) }
    @inlinable var ushort: UInt16 { UInt16(clamping: PyLong_AsUnsignedLong(self)) }
    @inlinable var int8: Int8 { Int8(clamping: PyLong_AsUnsignedLong(self)) }
    @inlinable var uint8: UInt8 { UInt8(clamping: PyLong_AsUnsignedLong(self)) }
    @inlinable var double: Double { PyFloat_AsDouble(self) }
    @inlinable var float: Float { Float(PyFloat_AsDouble(self)) }
    @inlinable var string: String { String.init(cString: PyUnicode_AsUTF8(self)) }
    
    
    
    
    @inlinable var iterator: PythonPointer? { PyObject_GetIter(self) }
    
    @inlinable var is_sequence: Bool { PySequence_Check(self) == 1 }
    @inlinable var is_dict: Bool { PythonDict_Check(self) }
    @inlinable var is_tuple: Bool { PythonTuple_Check(self)}
    @inlinable var is_unicode: Bool { PythonUnicode_Check(self) }
    @inlinable var is_int: Bool { PythonLong_Check(self) }
    @inlinable var is_float: Bool {PythonBool_Check(self) }
    @inlinable var is_iterator: Bool { PyIter_Check(self) == 1}
    @inlinable var is_bytearray: Bool { PythonByteArray_Check(self) }
    @inlinable var is_bytes: Bool { PythonBytes_Check(self) }
    
    @inlinable func decref() {
        Py_DecRef(self)
    }
    
    @inlinable
    func callAsFunction() {
        PyObject_Vectorcall(self, [], 0, nil)
    }
    
    @inlinable
    func callAsFunction(_ args: PythonPointer?...) {
        PyObject_Vectorcall(self, args, args.count, nil)
    }
    
    @inlinable
    func callAsFunction(_ args: [PythonPointer?]) {
        PyObject_Vectorcall(self, args, args.count, nil)
    }
    
    @inlinable
    func callAsFunction(_ args: [PythonPointer?], arg_count: Int) {
        PyObject_Vectorcall(self, args, arg_count, nil)
    }
}

extension String {
    
    
}
