import Foundation

extension PythonPointer {

    @inlinable
    public subscript(index: Int) -> PythonPointer {
        
        get {
            if PythonList_Check(self) {
                return PyList_GetItem(self, index)!
            }
            if PythonTuple_Check(self) {
                return PyTuple_GetItem(self, index)!
            }
            return nil
            }
            
        set {
            if PythonList_Check(self) {
                PyList_SetItem(self, index, newValue)
            }
            if PythonTuple_Check(self) {
                PyTuple_SetItem(self, index, newValue)
            }
        }
    }

    @inlinable
    public subscript(index: Int) -> PythonPointerU {
        
        get {
            if PythonList_Check(self) {
                return PyList_GetItem(self, index)
            }
            if PythonTuple_Check(self) {
                return PyTuple_GetItem(self, index)
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                PyList_SetItem(self, index, newValue)
            }
            if PythonTuple_Check(self) {
                PyTuple_SetItem(self, index, newValue)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> PythonPointerU {
        get {
            if PythonList_Check(self) { return PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound) }
            fatalError()
        }
        set {
            if PythonList_Check(self) { PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, newValue) }
        }
    }
    
    @inlinable
    public subscript(bounds: Range<Int>) -> PythonPointer {
        get {
            if PythonList_Check(self) { return PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound) }
            return nil
        }
        set {
            if PythonList_Check(self) { PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, newValue) }
        }
    }

        @inlinable
    public subscript(index: Int) -> String {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = String(cString: PyUnicode_AsUTF8(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = String(cString: PyUnicode_AsUTF8(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyUnicode_FromString(newValue)
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyUnicode_FromString(newValue)
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [String] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [String] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> Int {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = PyLong_AsLong(temp)
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = PyLong_AsLong(temp)
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromLong(newValue)
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromLong(newValue)
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [Int] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [Int] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> UInt {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = PyLong_AsUnsignedLong(temp)
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = PyLong_AsUnsignedLong(temp)
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromUnsignedLong(newValue)
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromUnsignedLong(newValue)
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [UInt] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [UInt] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> Int64 {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = PyLong_AsLongLong(temp)
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = PyLong_AsLongLong(temp)
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromLongLong(newValue)
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromLongLong(newValue)
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [Int64] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [Int64] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> UInt64 {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = PyLong_AsUnsignedLongLong(temp)
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = PyLong_AsUnsignedLongLong(temp)
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromUnsignedLongLong(newValue)
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromUnsignedLongLong(newValue)
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [UInt64] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [UInt64] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> Int32 {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = Int32(PyLong_AsLong(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = Int32(PyLong_AsLong(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromLong(Int(newValue))
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromLong(Int(newValue))
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [Int32] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [Int32] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> UInt32 {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = UInt32(PyLong_AsUnsignedLong(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = UInt32(PyLong_AsUnsignedLong(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromUnsignedLong(UInt(newValue))
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromUnsignedLong(UInt(newValue))
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [UInt32] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [UInt32] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> Int16 {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = Int16(PyLong_AsLong(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = Int16(PyLong_AsLong(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromLong(Int(newValue))
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromLong(Int(newValue))
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [Int16] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [Int16] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> UInt16 {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = UInt16(PyLong_AsUnsignedLong(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = UInt16(PyLong_AsUnsignedLong(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromUnsignedLong(UInt(newValue))
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromUnsignedLong(UInt(newValue))
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [UInt16] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [UInt16] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> Int8 {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = Int8(PyLong_AsLong(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = Int8(PyLong_AsLong(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromLong(Int(newValue))
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromLong(Int(newValue))
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [Int8] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [Int8] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> UInt8 {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = UInt8(PyLong_AsUnsignedLong(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = UInt8(PyLong_AsUnsignedLong(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyLong_FromUnsignedLong(UInt(newValue))
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyLong_FromUnsignedLong(UInt(newValue))
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [UInt8] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [UInt8] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> Float {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = Float(PyFloat_AsDouble(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = Float(PyFloat_AsDouble(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyFloat_FromDouble(Double(newValue))
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyFloat_FromDouble(Double(newValue))
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [Float] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [Float] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    
    @inlinable
    public subscript(index: Int) -> Double {
        
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetItem(self, index)
                let value = Double(PyFloat_AsDouble(temp))
                Py_DecRef(temp)
                return value
            }
            if PythonTuple_Check(self) {
                let temp = PyTuple_GetItem(self, index)
                let value = Double(PyFloat_AsDouble(temp))
                Py_DecRef(temp)
                return value
            }
            fatalError()
            }
            
        set {
            if PythonList_Check(self) {
                let temp = PyFloat_FromDouble(newValue)
                PyList_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
            if PythonTuple_Check(self) {
                let temp = PyFloat_FromDouble(newValue)
                PyTuple_SetItem(self, index, temp)
                Py_DecRef(temp)
            }
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> [Double] {
        get {
            if PythonList_Check(self) {
                let temp = PyList_GetSlice(self, bounds.lowerBound, bounds.upperBound)
                let array: [Double] = temp.array()
                Py_DecRef(temp)
                return array
            }
            fatalError()
        }
        set {
            if PythonList_Check(self) {
                let list = newValue.list_object
                PyList_SetSlice(self, bounds.lowerBound, bounds.upperBound, list)
                Py_DecRef(list)
            }
        }
    }
    

}