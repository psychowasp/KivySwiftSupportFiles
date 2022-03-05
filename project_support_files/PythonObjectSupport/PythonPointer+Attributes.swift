extension PythonPointer {


    @inlinable
    func setAttr(key: String, value: String) {
        PyObject_SetAttrString(self, key, PyUnicode_FromString(value))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: String) {
        PyObject_SetAttr(self, key, PyUnicode_FromString(value))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: String) {
        PyObject_SetAttr(self, key, PyUnicode_FromString(value))
    }


    @inlinable
    func setAttr(key: String, value: Int) {
        PyObject_SetAttrString(self, key, PyLong_FromLong(value))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: Int) {
        PyObject_SetAttr(self, key, PyLong_FromLong(value))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: Int) {
        PyObject_SetAttr(self, key, PyLong_FromLong(value))
    }


    @inlinable
    func setAttr(key: String, value: UInt) {
        PyObject_SetAttrString(self, key, PyLong_FromUnsignedLong(value))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: UInt) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLong(value))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: UInt) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLong(value))
    }


    @inlinable
    func setAttr(key: String, value: Int64) {
        PyObject_SetAttrString(self, key, PyLong_FromLongLong(value))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: Int64) {
        PyObject_SetAttr(self, key, PyLong_FromLongLong(value))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: Int64) {
        PyObject_SetAttr(self, key, PyLong_FromLongLong(value))
    }


    @inlinable
    func setAttr(key: String, value: UInt64) {
        PyObject_SetAttrString(self, key, PyLong_FromUnsignedLongLong(value))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: UInt64) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLongLong(value))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: UInt64) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLongLong(value))
    }


    @inlinable
    func setAttr(key: String, value: Int32) {
        PyObject_SetAttrString(self, key, PyLong_FromLong(Int(value)))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: Int32) {
        PyObject_SetAttr(self, key, PyLong_FromLong(Int(value)))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: Int32) {
        PyObject_SetAttr(self, key, PyLong_FromLong(Int(value)))
    }


    @inlinable
    func setAttr(key: String, value: UInt32) {
        PyObject_SetAttrString(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: UInt32) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: UInt32) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }


    @inlinable
    func setAttr(key: String, value: Int16) {
        PyObject_SetAttrString(self, key, PyLong_FromLong(Int(value)))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: Int16) {
        PyObject_SetAttr(self, key, PyLong_FromLong(Int(value)))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: Int16) {
        PyObject_SetAttr(self, key, PyLong_FromLong(Int(value)))
    }


    @inlinable
    func setAttr(key: String, value: UInt16) {
        PyObject_SetAttrString(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: UInt16) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: UInt16) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }


    @inlinable
    func setAttr(key: String, value: Int8) {
        PyObject_SetAttrString(self, key, PyLong_FromLong(Int(value)))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: Int8) {
        PyObject_SetAttr(self, key, PyLong_FromLong(Int(value)))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: Int8) {
        PyObject_SetAttr(self, key, PyLong_FromLong(Int(value)))
    }


    @inlinable
    func setAttr(key: String, value: UInt8) {
        PyObject_SetAttrString(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: UInt8) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: UInt8) {
        PyObject_SetAttr(self, key, PyLong_FromUnsignedLong(UInt(value)))
    }


    @inlinable
    func setAttr(key: String, value: Float) {
        PyObject_SetAttrString(self, key, PyFloat_FromDouble(Double(value)))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: Float) {
        PyObject_SetAttr(self, key, PyFloat_FromDouble(Double(value)))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: Float) {
        PyObject_SetAttr(self, key, PyFloat_FromDouble(Double(value)))
    }


    @inlinable
    func setAttr(key: String, value: Double) {
        PyObject_SetAttrString(self, key, PyFloat_FromDouble(value))
    }
    
    @inlinable
    func setAttr(key: PythonPointer, value: Double) {
        PyObject_SetAttr(self, key, PyFloat_FromDouble(value))
    }

    @inlinable
    func setAttr(key: PythonPointer?, value: Double) {
        PyObject_SetAttr(self, key, PyFloat_FromDouble(value))
    }


    
    @inlinable
    func getAttr(key: String) -> PythonPointer {
        let attr = PyObject_GetAttrString(self, key)
        let value = attr
        Py_DecRef(attr)
        return value!
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> PythonPointer {
        let attr = PyObject_GetAttr(self, key)
        let value = attr
        Py_DecRef(attr)
        return value!
    }

    @inlinable
    func getAttr(key: PythonPointer) -> PythonPointer {
        let attr = PyObject_GetAttr(self, key)
        let value = attr
        Py_DecRef(attr)
        return value!
    }

    
    @inlinable
    func getAttr(key: String) -> PythonPointer? {
        let attr = PyObject_GetAttrString(self, key)
        let value = attr
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> PythonPointer? {
        let attr = PyObject_GetAttr(self, key)
        let value = attr
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> PythonPointer? {
        let attr = PyObject_GetAttr(self, key)
        let value = attr
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> String {
        let attr = PyObject_GetAttrString(self, key)
        let value = String(cString: PyUnicode_AsUTF8(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> String {
        let attr = PyObject_GetAttr(self, key)
        let value = String(cString: PyUnicode_AsUTF8(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> String {
        let attr = PyObject_GetAttr(self, key)
        let value = String(cString: PyUnicode_AsUTF8(attr))
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> Int {
        let attr = PyObject_GetAttrString(self, key)
        let value = PyLong_AsLong(attr)
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> Int {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsLong(attr)
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> Int {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsLong(attr)
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> UInt {
        let attr = PyObject_GetAttrString(self, key)
        let value = PyLong_AsUnsignedLong(attr)
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> UInt {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsUnsignedLong(attr)
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> UInt {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsUnsignedLong(attr)
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> Int64 {
        let attr = PyObject_GetAttrString(self, key)
        let value = PyLong_AsLongLong(attr)
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> Int64 {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsLongLong(attr)
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> Int64 {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsLongLong(attr)
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> UInt64 {
        let attr = PyObject_GetAttrString(self, key)
        let value = PyLong_AsUnsignedLongLong(attr)
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> UInt64 {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsUnsignedLongLong(attr)
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> UInt64 {
        let attr = PyObject_GetAttr(self, key)
        let value = PyLong_AsUnsignedLongLong(attr)
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> Int32 {
        let attr = PyObject_GetAttrString(self, key)
        let value = Int32(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> Int32 {
        let attr = PyObject_GetAttr(self, key)
        let value = Int32(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> Int32 {
        let attr = PyObject_GetAttr(self, key)
        let value = Int32(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> UInt32 {
        let attr = PyObject_GetAttrString(self, key)
        let value = UInt32(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> UInt32 {
        let attr = PyObject_GetAttr(self, key)
        let value = UInt32(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> UInt32 {
        let attr = PyObject_GetAttr(self, key)
        let value = UInt32(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> Int16 {
        let attr = PyObject_GetAttrString(self, key)
        let value = Int16(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> Int16 {
        let attr = PyObject_GetAttr(self, key)
        let value = Int16(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> Int16 {
        let attr = PyObject_GetAttr(self, key)
        let value = Int16(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> UInt16 {
        let attr = PyObject_GetAttrString(self, key)
        let value = UInt16(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> UInt16 {
        let attr = PyObject_GetAttr(self, key)
        let value = UInt16(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> UInt16 {
        let attr = PyObject_GetAttr(self, key)
        let value = UInt16(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> Int8 {
        let attr = PyObject_GetAttrString(self, key)
        let value = Int8(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> Int8 {
        let attr = PyObject_GetAttr(self, key)
        let value = Int8(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> Int8 {
        let attr = PyObject_GetAttr(self, key)
        let value = Int8(PyLong_AsLong(attr))
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> UInt8 {
        let attr = PyObject_GetAttrString(self, key)
        let value = UInt8(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> UInt8 {
        let attr = PyObject_GetAttr(self, key)
        let value = UInt8(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> UInt8 {
        let attr = PyObject_GetAttr(self, key)
        let value = UInt8(PyLong_AsUnsignedLong(attr))
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> Float {
        let attr = PyObject_GetAttrString(self, key)
        let value = Float(PyFloat_AsDouble(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> Float {
        let attr = PyObject_GetAttr(self, key)
        let value = Float(PyFloat_AsDouble(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> Float {
        let attr = PyObject_GetAttr(self, key)
        let value = Float(PyFloat_AsDouble(attr))
        Py_DecRef(attr)
        return value
    }

    
    @inlinable
    func getAttr(key: String) -> Double {
        let attr = PyObject_GetAttrString(self, key)
        let value = Double(PyFloat_AsDouble(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer?) -> Double {
        let attr = PyObject_GetAttr(self, key)
        let value = Double(PyFloat_AsDouble(attr))
        Py_DecRef(attr)
        return value
    }

    @inlinable
    func getAttr(key: PythonPointer) -> Double {
        let attr = PyObject_GetAttr(self, key)
        let value = Double(PyFloat_AsDouble(attr))
        Py_DecRef(attr)
        return value
    }


}