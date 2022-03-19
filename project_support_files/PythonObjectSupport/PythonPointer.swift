import Foundation
import CoreGraphics

public typealias PythonPointer = UnsafeMutablePointer<PyObject>?
public typealias PythonPointerU = UnsafeMutablePointer<PyObject>

extension PythonPointer: Sequence, IteratorProtocol {

    public typealias Element = PythonPointer
    public typealias Iterator = PythonPointer
    @inlinable
    public mutating func next() -> PythonPointer? {
        PyIter_Next(self)
    }
    
    @inlinable
        public func getBuffer() -> UnsafeBufferPointer<PythonPointer> {
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
    @inlinable var bool: Bool { return PyObject_IsTrue(self) == 1}
    
    @inlinable var _string: String? {
        let kind = PythonUnicode_KIND(self)
        let length = PyUnicode_GetLength(self)
        let ptr = PythonUnicode_DATA(self)!
        switch PythonUnicode_Kind(rawValue: kind) {
        case .PyUnicode_WCHAR_KIND:
            return "wchars not tested"
        case .PyUnicode_1BYTE_KIND:
            let size = length * MemoryLayout<Py_UCS1>.stride
            let data = Data(bytesNoCopy: ptr, count: size, deallocator: .none)
            return String(data: data, encoding: .utf8)
        case .PyUnicode_2BYTE_KIND:
            let size = length * MemoryLayout<Py_UCS2>.stride
            let data = Data(bytesNoCopy: ptr, count: size, deallocator: .none)
            return String(data: data, encoding: .utf16LittleEndian)
        case .PyUnicode_4BYTE_KIND:
            let size = length * MemoryLayout<Py_UCS1>.stride
            let data = Data(bytesNoCopy: ptr, count: size, deallocator: .none)
            return String(data: data, encoding: .utf32LittleEndian)
        case .none:
            print(".none",kind)
            return nil
        }
    }
    
    
    
    
    
    
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
    
    @inlinable func incref() {
        Py_IncRef(self)
    }
    
    
    
    @inlinable
    func callAsFunction(_ args: [PythonPointer], arg_count: Int) {
        PyObject_Vectorcall(self, args, arg_count, nil)
    }
    
    @inlinable
    func callAsFunction(){
        PyObject_CallNoArgs(self)
    }
    
    @inlinable
    func callAsFunction(_ arg: PythonPointer){
        PyObject_CallOneArg(self, arg)
    }
    
    
    
    @inlinable
    func callAsFunction(_ args: PythonPointer...){
        PyObject_Vectorcall(self, args, args.count, nil)
    }
    
    @inlinable
    func callAsFunction(_ args: [PythonPointer]){
        PyObject_Vectorcall(self, args, args.count, nil)
    }
    
    @inlinable
    func callAsFunction(_ args: [PythonPointer], arg_names: PythonPointer){
        PyObject_Vectorcall(self, args, args.count, arg_names)
    }
    
    @inlinable
    func callAsFunction(_ args: PythonPointer..., arg_names: PythonPointer){
        PyObject_Vectorcall(self, args, args.count, nil)
    }
    
    @inlinable
    func withCall(_ code: @escaping ()->[PythonPointer] ) -> PythonPointer {
        let args = code()
        return PyObject_Vectorcall(self, args, args.count, nil)
    }
}

extension String {
    
    
}


public enum PythonUnicode_Kind: UInt32 {
/* String contains only wstr byte characters.  This is only possible
   when the string was created with a legacy API and _PyUnicode_Ready()
   has not been called yet.  */
    case PyUnicode_WCHAR_KIND = 0
/* Return values of the PyUnicode_KIND() macro: */
    case PyUnicode_1BYTE_KIND = 1
    case PyUnicode_2BYTE_KIND = 2
    case PyUnicode_4BYTE_KIND = 4
}


func bytesAsDataNoCopy(bytes: PythonPointer) -> Data? {
    let data_size = PyBytes_Size(bytes)
    // PyBytes to MemoryView
    let mview = PyMemoryView_FromObject(bytes)
    // fetch PyBuffer from MemoryView
    let py_buf = PythonMemoryView_GET_BUFFER(mview)
    var indices = [0]
    // fetch RawPointer from PyBuffer, if fail return nil
    guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
    let data = Data(bytesNoCopy: buf_ptr, count: data_size, deallocator: .none)
    // Release PyBuffer and MemoryView
    Py_DecRef(mview)
    return data
}

func bytearrayAsDataNoCopy(bytes: PythonPointer) -> Data? {
    let data_size = PyByteArray_Size(bytes)
    // PyBytes to MemoryView
    let mview = PyMemoryView_FromObject(bytes)
    // fetch PyBuffer from MemoryView
    let py_buf = PythonMemoryView_GET_BUFFER(mview)
    var indices = [0]
    // fetch RawPointer from PyBuffer, if fail return nil
    guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
    let data = Data(bytesNoCopy: buf_ptr, count: data_size, deallocator: .none)
    // Release PyBuffer and MemoryView
    Py_DecRef(mview)
    return data
}

func memoryviewAsDataNoCopy(view: PythonPointer) -> Data? {
    let data_size = PyObject_Size(view)
    // fetch PyBuffer from MemoryView
    let py_buf = PythonMemoryView_GET_BUFFER(view)
    var indices = [0]
    // fetch RawPointer from PyBuffer, if fail return nil
    guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
    return Data(bytesNoCopy: buf_ptr, count: data_size, deallocator: .none)
}


func bytesSlicedAsDataNoCopy(bytes: PythonPointer, start: Int, size: Int) -> Data? {
    // PyBytes to MemoryView
    let mview = PyMemoryView_FromObject(bytes)
    // fetch PyBuffer from MemoryView
    let py_buf = PythonMemoryView_GET_BUFFER(mview)
    var indices = [start]
    // fetch RawPointer from PyBuffer, if fail return nil
    guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
    let data = Data(bytesNoCopy: buf_ptr, count: size, deallocator: .none)
    // Release PyBuffer and MemoryView
    Py_DecRef(mview)
    return data
}

func memoryviewSlicedAsDataNoCopy(view: PythonPointer, start: Int, size: Int) -> Data? {
    // fetch PyBuffer from MemoryView
    let py_buf = PythonMemoryView_GET_BUFFER(view)
    var indices = [start]
    // fetch RawPointer from PyBuffer, if fail return nil
    guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
    let data = Data(bytesNoCopy: buf_ptr, count: size, deallocator: .none)
    // Release PyBuffer and MemoryView
    return data
}

extension PythonPointer {
    // PyBytes -> Data
    func bytesAsData() -> Data? {
        let data_size = PyBytes_Size(self)
        // PyBytes to MemoryView
        let mview = PyMemoryView_FromObject(self)
        // fetch PyBuffer from MemoryView
        let py_buf = PythonMemoryView_GET_BUFFER(mview)
        var indices = [0]
        // fetch RawPointer from PyBuffer, if fail return nil
        guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
        // cast RawPointer as UInt8 pointer
        let data = Data(bytes: buf_ptr, count: data_size)
        // Release MemoryView
        Py_DecRef(mview)
        return data
    }
    
    func bytesSlicedAsData(start: Int, size: Int) -> Data? {
        // PyBytes to MemoryView
        let mview = PyMemoryView_FromObject(self)
        // fetch PyBuffer from MemoryView
        let py_buf = PythonMemoryView_GET_BUFFER(mview)
        var indices = [start]
        // fetch RawPointer from PyBuffer, if fail return nil
        guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
        let data = Data(bytes: buf_ptr, count: size)
        // Release MemoryView
        Py_DecRef(mview)
        return data
    }
    
    func bytearrayAsData() -> Data? {
        let data_size = PyByteArray_Size(self)
        // PyBytes to MemoryView
        let mview = PyMemoryView_FromObject(self)
        // fetch PyBuffer from MemoryView
        let py_buf = PythonMemoryView_GET_BUFFER(mview)
        var indices = [0]
        // fetch RawPointer from PyBuffer, if fail return nil
        guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
        // cast RawPointer as UInt8 pointer
        let data = Data(bytes: buf_ptr, count: data_size)
        // Release MemoryView
        Py_DecRef(mview)
        return data
    }
    
    func memoryViewAsData() -> Data? {
        let data_size = PyObject_Size(self)
        // fetch PyBuffer from MemoryView
        let py_buf = PythonMemoryView_GET_BUFFER(self)
        var indices = [0]
        // fetch RawPointer from PyBuffer, if fail return nil
        guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
        // cast RawPointer as UInt8 pointer
        let uint8_pointer = buf_ptr.assumingMemoryBound(to: UInt8.self)
        // finally create Data from the UInt8 pointer
        let data = Data(UnsafeMutableBufferPointer(start: uint8_pointer, count: data_size))
        // Release PyBuffer and MemoryView
        PyBuffer_Release(py_buf)
        return data
    }
    
    func memoryViewSlicedAsData(start: Int, size: Int) -> Data? {
        // fetch PyBuffer from MemoryView
        let py_buf = PythonMemoryView_GET_BUFFER(self)
        var indices = [start]
        // fetch RawPointer from PyBuffer, if fail return nil
        guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
        return Data(bytes: buf_ptr, count: size)
    }
    
    func bytesAsArray() -> [UInt8]? {
        let data_size = PyBytes_Size(self)
        // PyBytes to MemoryView
        let mview = PyMemoryView_FromObject(self)
        // fetch PyBuffer from MemoryView
        let py_buf = PythonMemoryView_GET_BUFFER(mview)
        var indices = [0]
        // fetch RawPointer from PyBuffer, if fail return nil
        guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
        // finally create Array<UInt8> from the buf_ptr
        let array = [UInt8](UnsafeBufferPointer(
            start: buf_ptr.assumingMemoryBound(to: UInt8.self),
            count: data_size)
        )
        // Release PyBuffer and MemoryView
        Py_DecRef(mview)
        return array
    }
    
    func bytearrayAsArray() -> [UInt8]? {
        let data_size = PyByteArray_Size(self)
        // PyBytes to MemoryView
        let mview = PyMemoryView_FromObject(self)
        // fetch PyBuffer from MemoryView
        let py_buf = PythonMemoryView_GET_BUFFER(mview)
        var indices = [0]
        // fetch RawPointer from PyBuffer, if fail return nil
        guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
        // cast RawPointer as UInt8 pointer
        let array = [UInt8](UnsafeBufferPointer(
            start: buf_ptr.assumingMemoryBound(to: UInt8.self),
            count: data_size)
        )
        // Release MemoryView
        Py_DecRef(mview)
        return array
    }
    
    func memoryViewAsArray() -> [UInt8]? {
        let data_size = PyObject_Size(self)
        // fetch PyBuffer from MemoryView
        let py_buf = PythonMemoryView_GET_BUFFER(self)
        var indices = [0]
        // fetch RawPointer from PyBuffer, if fail return nil
        guard let buf_ptr = PyBuffer_GetPointer(py_buf, &indices) else { return nil}
        // finally create Array<UInt8> from the buf_ptr
        let array = [UInt8](UnsafeBufferPointer(
            start: buf_ptr.assumingMemoryBound(to: UInt8.self),
            count: data_size)
        )
        return array
    }
    
    
    
    
}

@inlinable func asPyBool(_ state: Bool) -> PythonPointer {
    if state { return PythonTrue }
    
    return PythonFalse
}

extension Bool {
    @inlinable var object: PythonPointer {
        if self { return PythonTrue }
        return PythonFalse
    }
}
