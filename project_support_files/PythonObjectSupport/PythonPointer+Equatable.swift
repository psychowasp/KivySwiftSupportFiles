import Foundation



extension PythonPointer {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return PyNumber_Add( lhs , rhs )
    }
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return PyNumber_Subtract( lhs , rhs )
    }
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return PyNumber_TrueDivide( lhs , rhs )
    }
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return PyNumber_Multiply( lhs , rhs )
    }
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return PyNumber_Add( lhs , rhs )
    }
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return PyNumber_Subtract( lhs , rhs )
    }
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return PyNumber_TrueDivide( lhs , rhs )
    }
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return PyNumber_Multiply( lhs , rhs )
    }
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(lhs, rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return PyNumber_Add( lhs , rhs )
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyNumber_Add( lhs , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return PyNumber_Subtract( lhs , rhs )
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyNumber_Subtract( lhs , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return PyNumber_TrueDivide( lhs , rhs )
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyNumber_TrueDivide( lhs , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return PyNumber_Multiply( lhs , rhs )
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyNumber_Multiply( lhs , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return PyNumber_Add( lhs , rhs )
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyNumber_Add( lhs , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return PyNumber_Subtract( lhs , rhs )
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyNumber_Subtract( lhs , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return PyNumber_TrueDivide( lhs , rhs )
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyNumber_TrueDivide( lhs , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return PyNumber_Multiply( lhs , rhs )
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyNumber_Multiply( lhs , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: String) -> Bool {
        return PyObject_RichCompareBool(lhs, PyUnicode_FromString(rhs), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: String) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyUnicode_FromString(rhs), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: String) -> Bool {
        return PyObject_RichCompareBool(lhs, PyUnicode_FromString(rhs), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: String) -> Bool {
        return PyObject_RichCompareBool(lhs, PyUnicode_FromString(rhs), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: String) -> Bool {
        return PyObject_RichCompareBool(lhs, PyUnicode_FromString(rhs), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: String) -> Bool {
        return PyObject_RichCompareBool(lhs, PyUnicode_FromString(rhs), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: String) -> Self {
        return PyNumber_Add( lhs , PyUnicode_FromString(rhs) )
    }
    @inlinable static func += (lhs:  String, rhs: Self) -> Self {
        return PyNumber_Add( PyUnicode_FromString(lhs) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: String) -> Self {
        return PyNumber_Subtract( lhs , PyUnicode_FromString(rhs) )
    }
    @inlinable static func -= (lhs:  String, rhs: Self) -> Self {
        return PyNumber_Subtract( PyUnicode_FromString(lhs) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: String) -> Self {
        return PyNumber_TrueDivide( lhs , PyUnicode_FromString(rhs) )
    }
    @inlinable static func /= (lhs:  String, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyUnicode_FromString(lhs) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: String) -> Self {
        return PyNumber_Multiply( lhs , PyUnicode_FromString(rhs) )
    }
    @inlinable static func *= (lhs:  String, rhs: Self) -> Self {
        return PyNumber_Multiply( PyUnicode_FromString(lhs) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: String) -> Self {
        return PyNumber_Add( lhs , PyUnicode_FromString(rhs) )
    }
    @inlinable static func + (lhs:  String, rhs: Self) -> Self {
        return PyNumber_Add( PyUnicode_FromString(lhs) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: String) -> Self {
        return PyNumber_Subtract( lhs , PyUnicode_FromString(rhs) )
    }
    @inlinable static func - (lhs:  String, rhs: Self) -> Self {
        return PyNumber_Subtract( PyUnicode_FromString(lhs) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: String) -> Self {
        return PyNumber_TrueDivide( lhs , PyUnicode_FromString(rhs) )
    }
    @inlinable static func / (lhs:  String, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyUnicode_FromString(lhs) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: String) -> Self {
        return PyNumber_Multiply( lhs , PyUnicode_FromString(rhs) )
    }
    @inlinable static func * (lhs:  String, rhs: Self) -> Self {
        return PyNumber_Multiply( PyUnicode_FromString(lhs) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: Int) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(rhs), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: Int) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(rhs), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: Int) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(rhs), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: Int) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(rhs), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: Int) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(rhs), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: Int) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(rhs), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: Int) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLong(rhs) )
    }
    @inlinable static func += (lhs:  Int, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLong(lhs) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: Int) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLong(rhs) )
    }
    @inlinable static func -= (lhs:  Int, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLong(lhs) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: Int) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLong(rhs) )
    }
    @inlinable static func /= (lhs:  Int, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLong(lhs) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: Int) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLong(rhs) )
    }
    @inlinable static func *= (lhs:  Int, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLong(lhs) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: Int) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLong(rhs) )
    }
    @inlinable static func + (lhs:  Int, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLong(lhs) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: Int) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLong(rhs) )
    }
    @inlinable static func - (lhs:  Int, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLong(lhs) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: Int) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLong(rhs) )
    }
    @inlinable static func / (lhs:  Int, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLong(lhs) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: Int) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLong(rhs) )
    }
    @inlinable static func * (lhs:  Int, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLong(lhs) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: UInt) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(rhs), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: UInt) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(rhs), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: UInt) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(rhs), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: UInt) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(rhs), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: UInt) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(rhs), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: UInt) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(rhs), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: UInt) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLong(rhs) )
    }
    @inlinable static func += (lhs:  UInt, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLong(lhs) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: UInt) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLong(rhs) )
    }
    @inlinable static func -= (lhs:  UInt, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLong(lhs) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: UInt) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLong(rhs) )
    }
    @inlinable static func /= (lhs:  UInt, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLong(lhs) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: UInt) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLong(rhs) )
    }
    @inlinable static func *= (lhs:  UInt, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLong(lhs) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: UInt) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLong(rhs) )
    }
    @inlinable static func + (lhs:  UInt, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLong(lhs) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: UInt) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLong(rhs) )
    }
    @inlinable static func - (lhs:  UInt, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLong(lhs) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: UInt) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLong(rhs) )
    }
    @inlinable static func / (lhs:  UInt, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLong(lhs) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: UInt) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLong(rhs) )
    }
    @inlinable static func * (lhs:  UInt, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLong(lhs) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: Int64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLongLong(rhs), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: Int64) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromLongLong(rhs), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: Int64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLongLong(rhs), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: Int64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLongLong(rhs), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: Int64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLongLong(rhs), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: Int64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLongLong(rhs), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: Int64) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLongLong(rhs) )
    }
    @inlinable static func += (lhs:  Int64, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLongLong(lhs) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: Int64) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLongLong(rhs) )
    }
    @inlinable static func -= (lhs:  Int64, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLongLong(lhs) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: Int64) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLongLong(rhs) )
    }
    @inlinable static func /= (lhs:  Int64, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLongLong(lhs) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: Int64) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLongLong(rhs) )
    }
    @inlinable static func *= (lhs:  Int64, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLongLong(lhs) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: Int64) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLongLong(rhs) )
    }
    @inlinable static func + (lhs:  Int64, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLongLong(lhs) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: Int64) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLongLong(rhs) )
    }
    @inlinable static func - (lhs:  Int64, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLongLong(lhs) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: Int64) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLongLong(rhs) )
    }
    @inlinable static func / (lhs:  Int64, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLongLong(lhs) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: Int64) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLongLong(rhs) )
    }
    @inlinable static func * (lhs:  Int64, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLongLong(lhs) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: UInt64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLongLong(rhs), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: UInt64) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLongLong(rhs), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: UInt64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLongLong(rhs), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: UInt64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLongLong(rhs), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: UInt64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLongLong(rhs), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: UInt64) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLongLong(rhs), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: UInt64) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLongLong(rhs) )
    }
    @inlinable static func += (lhs:  UInt64, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLongLong(lhs) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: UInt64) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLongLong(rhs) )
    }
    @inlinable static func -= (lhs:  UInt64, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLongLong(lhs) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: UInt64) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLongLong(rhs) )
    }
    @inlinable static func /= (lhs:  UInt64, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLongLong(lhs) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: UInt64) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLongLong(rhs) )
    }
    @inlinable static func *= (lhs:  UInt64, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLongLong(lhs) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: UInt64) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLongLong(rhs) )
    }
    @inlinable static func + (lhs:  UInt64, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLongLong(lhs) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: UInt64) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLongLong(rhs) )
    }
    @inlinable static func - (lhs:  UInt64, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLongLong(lhs) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: UInt64) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLongLong(rhs) )
    }
    @inlinable static func / (lhs:  UInt64, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLongLong(lhs) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: UInt64) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLongLong(rhs) )
    }
    @inlinable static func * (lhs:  UInt64, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLongLong(lhs) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: Int32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: Int32) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: Int32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: Int32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: Int32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: Int32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: Int32) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func += (lhs:  Int32, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: Int32) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func -= (lhs:  Int32, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: Int32) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func /= (lhs:  Int32, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: Int32) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func *= (lhs:  Int32, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: Int32) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func + (lhs:  Int32, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: Int32) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func - (lhs:  Int32, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: Int32) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func / (lhs:  Int32, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: Int32) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func * (lhs:  Int32, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: UInt32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: UInt32) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: UInt32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: UInt32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: UInt32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: UInt32) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: UInt32) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func += (lhs:  UInt32, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: UInt32) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func -= (lhs:  UInt32, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: UInt32) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func /= (lhs:  UInt32, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: UInt32) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func *= (lhs:  UInt32, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: UInt32) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func + (lhs:  UInt32, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: UInt32) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func - (lhs:  UInt32, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: UInt32) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func / (lhs:  UInt32, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: UInt32) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func * (lhs:  UInt32, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: Int16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: Int16) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: Int16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: Int16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: Int16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: Int16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: Int16) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func += (lhs:  Int16, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: Int16) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func -= (lhs:  Int16, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: Int16) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func /= (lhs:  Int16, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: Int16) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func *= (lhs:  Int16, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: Int16) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func + (lhs:  Int16, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: Int16) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func - (lhs:  Int16, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: Int16) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func / (lhs:  Int16, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: Int16) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func * (lhs:  Int16, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: UInt16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: UInt16) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: UInt16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: UInt16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: UInt16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: UInt16) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: UInt16) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func += (lhs:  UInt16, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: UInt16) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func -= (lhs:  UInt16, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: UInt16) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func /= (lhs:  UInt16, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: UInt16) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func *= (lhs:  UInt16, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: UInt16) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func + (lhs:  UInt16, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: UInt16) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func - (lhs:  UInt16, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: UInt16) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func / (lhs:  UInt16, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: UInt16) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func * (lhs:  UInt16, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: Int8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: Int8) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: Int8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: Int8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: Int8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: Int8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromLong(Int(rhs)), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: Int8) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func += (lhs:  Int8, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: Int8) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func -= (lhs:  Int8, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: Int8) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func /= (lhs:  Int8, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: Int8) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func *= (lhs:  Int8, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: Int8) -> Self {
        return PyNumber_Add( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func + (lhs:  Int8, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: Int8) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func - (lhs:  Int8, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: Int8) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func / (lhs:  Int8, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: Int8) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromLong(Int(rhs)) )
    }
    @inlinable static func * (lhs:  Int8, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromLong(Int(lhs)) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: UInt8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: UInt8) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: UInt8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: UInt8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: UInt8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: UInt8) -> Bool {
        return PyObject_RichCompareBool(lhs, PyLong_FromUnsignedLong(UInt(rhs)), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: UInt8) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func += (lhs:  UInt8, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: UInt8) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func -= (lhs:  UInt8, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: UInt8) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func /= (lhs:  UInt8, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: UInt8) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func *= (lhs:  UInt8, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: UInt8) -> Self {
        return PyNumber_Add( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func + (lhs:  UInt8, rhs: Self) -> Self {
        return PyNumber_Add( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: UInt8) -> Self {
        return PyNumber_Subtract( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func - (lhs:  UInt8, rhs: Self) -> Self {
        return PyNumber_Subtract( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: UInt8) -> Self {
        return PyNumber_TrueDivide( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func / (lhs:  UInt8, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: UInt8) -> Self {
        return PyNumber_Multiply( lhs , PyLong_FromUnsignedLong(UInt(rhs)) )
    }
    @inlinable static func * (lhs:  UInt8, rhs: Self) -> Self {
        return PyNumber_Multiply( PyLong_FromUnsignedLong(UInt(lhs)) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: Float) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(Double(rhs)), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: Float) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(Double(rhs)), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: Float) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(Double(rhs)), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: Float) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(Double(rhs)), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: Float) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(Double(rhs)), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: Float) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(Double(rhs)), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: Float) -> Self {
        return PyNumber_Add( lhs , PyFloat_FromDouble(Double(rhs)) )
    }
    @inlinable static func += (lhs:  Float, rhs: Self) -> Self {
        return PyNumber_Add( PyFloat_FromDouble(Double(lhs)) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: Float) -> Self {
        return PyNumber_Subtract( lhs , PyFloat_FromDouble(Double(rhs)) )
    }
    @inlinable static func -= (lhs:  Float, rhs: Self) -> Self {
        return PyNumber_Subtract( PyFloat_FromDouble(Double(lhs)) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: Float) -> Self {
        return PyNumber_TrueDivide( lhs , PyFloat_FromDouble(Double(rhs)) )
    }
    @inlinable static func /= (lhs:  Float, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyFloat_FromDouble(Double(lhs)) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: Float) -> Self {
        return PyNumber_Multiply( lhs , PyFloat_FromDouble(Double(rhs)) )
    }
    @inlinable static func *= (lhs:  Float, rhs: Self) -> Self {
        return PyNumber_Multiply( PyFloat_FromDouble(Double(lhs)) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: Float) -> Self {
        return PyNumber_Add( lhs , PyFloat_FromDouble(Double(rhs)) )
    }
    @inlinable static func + (lhs:  Float, rhs: Self) -> Self {
        return PyNumber_Add( PyFloat_FromDouble(Double(lhs)) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: Float) -> Self {
        return PyNumber_Subtract( lhs , PyFloat_FromDouble(Double(rhs)) )
    }
    @inlinable static func - (lhs:  Float, rhs: Self) -> Self {
        return PyNumber_Subtract( PyFloat_FromDouble(Double(lhs)) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: Float) -> Self {
        return PyNumber_TrueDivide( lhs , PyFloat_FromDouble(Double(rhs)) )
    }
    @inlinable static func / (lhs:  Float, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyFloat_FromDouble(Double(lhs)) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: Float) -> Self {
        return PyNumber_Multiply( lhs , PyFloat_FromDouble(Double(rhs)) )
    }
    @inlinable static func * (lhs:  Float, rhs: Self) -> Self {
        return PyNumber_Multiply( PyFloat_FromDouble(Double(lhs)) , rhs )
    }
    
    @inlinable static func == (lhs: Self, rhs: Double) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(rhs), Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: Double) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, lhs, Py_NE) == 1
        }
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(rhs), Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: Double) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(rhs), Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: Double) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(rhs), Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: Double) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(rhs), Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: Double) -> Bool {
        return PyObject_RichCompareBool(lhs, PyFloat_FromDouble(rhs), Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: Double) -> Self {
        return PyNumber_Add( lhs , PyFloat_FromDouble(rhs) )
    }
    @inlinable static func += (lhs:  Double, rhs: Self) -> Self {
        return PyNumber_Add( PyFloat_FromDouble(lhs) , rhs )
    }
    
    @inlinable static func -= (lhs:  Self, rhs: Double) -> Self {
        return PyNumber_Subtract( lhs , PyFloat_FromDouble(rhs) )
    }
    @inlinable static func -= (lhs:  Double, rhs: Self) -> Self {
        return PyNumber_Subtract( PyFloat_FromDouble(lhs) , rhs )
    }
    
    @inlinable static func /= (lhs:  Self, rhs: Double) -> Self {
        return PyNumber_TrueDivide( lhs , PyFloat_FromDouble(rhs) )
    }
    @inlinable static func /= (lhs:  Double, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyFloat_FromDouble(lhs) , rhs )
    }
    
    @inlinable static func *= (lhs:  Self, rhs: Double) -> Self {
        return PyNumber_Multiply( lhs , PyFloat_FromDouble(rhs) )
    }
    @inlinable static func *= (lhs:  Double, rhs: Self) -> Self {
        return PyNumber_Multiply( PyFloat_FromDouble(lhs) , rhs )
    }
    
    @inlinable static func + (lhs:  Self, rhs: Double) -> Self {
        return PyNumber_Add( lhs , PyFloat_FromDouble(rhs) )
    }
    @inlinable static func + (lhs:  Double, rhs: Self) -> Self {
        return PyNumber_Add( PyFloat_FromDouble(lhs) , rhs )
    }
    
    @inlinable static func - (lhs:  Self, rhs: Double) -> Self {
        return PyNumber_Subtract( lhs , PyFloat_FromDouble(rhs) )
    }
    @inlinable static func - (lhs:  Double, rhs: Self) -> Self {
        return PyNumber_Subtract( PyFloat_FromDouble(lhs) , rhs )
    }
    
    @inlinable static func / (lhs:  Self, rhs: Double) -> Self {
        return PyNumber_TrueDivide( lhs , PyFloat_FromDouble(rhs) )
    }
    @inlinable static func / (lhs:  Double, rhs: Self) -> Self {
        return PyNumber_TrueDivide( PyFloat_FromDouble(lhs) , rhs )
    }
    
    @inlinable static func * (lhs:  Self, rhs: Double) -> Self {
        return PyNumber_Multiply( lhs , PyFloat_FromDouble(rhs) )
    }
    @inlinable static func * (lhs:  Double, rhs: Self) -> Self {
        return PyNumber_Multiply( PyFloat_FromDouble(lhs) , rhs )
    }
    

}


extension String {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyUnicode_FromString(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + String(cString: PyUnicode_AsUTF8(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return String(cString: PyUnicode_AsUTF8(lhs)) + rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + String(cString: PyUnicode_AsUTF8(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return String(cString: PyUnicode_AsUTF8(lhs)) + rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyUnicode_FromString(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyUnicode_FromString(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + String(cString: PyUnicode_AsUTF8(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return String(cString: PyUnicode_AsUTF8(lhs)) + rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + String(cString: PyUnicode_AsUTF8(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return String(cString: PyUnicode_AsUTF8(lhs)) + rhs
    }
    

}

extension Int {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLong(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + PyLong_AsLong(rhs)
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - PyLong_AsLong(rhs)
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / PyLong_AsLong(rhs)
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * PyLong_AsLong(rhs)
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + PyLong_AsLong(rhs)
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - PyLong_AsLong(rhs)
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / PyLong_AsLong(rhs)
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * PyLong_AsLong(rhs)
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLong(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + PyLong_AsLong(rhs)
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - PyLong_AsLong(rhs)
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / PyLong_AsLong(rhs)
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * PyLong_AsLong(rhs)
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + PyLong_AsLong(rhs)
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - PyLong_AsLong(rhs)
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / PyLong_AsLong(rhs)
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * PyLong_AsLong(rhs)
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLong(lhs) * rhs
    }
    

}

extension UInt {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLong(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLong(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * PyLong_AsUnsignedLong(rhs)
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLong(lhs) * rhs
    }
    

}

extension Int64 {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLongLong(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + PyLong_AsLongLong(rhs)
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - PyLong_AsLongLong(rhs)
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / PyLong_AsLongLong(rhs)
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * PyLong_AsLongLong(rhs)
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + PyLong_AsLongLong(rhs)
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - PyLong_AsLongLong(rhs)
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / PyLong_AsLongLong(rhs)
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * PyLong_AsLongLong(rhs)
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLongLong(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLongLong(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + PyLong_AsLongLong(rhs)
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - PyLong_AsLongLong(rhs)
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / PyLong_AsLongLong(rhs)
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * PyLong_AsLongLong(rhs)
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + PyLong_AsLongLong(rhs)
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - PyLong_AsLongLong(rhs)
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / PyLong_AsLongLong(rhs)
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * PyLong_AsLongLong(rhs)
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsLongLong(lhs) * rhs
    }
    

}

extension UInt64 {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLongLong(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLongLong(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLongLong(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * PyLong_AsUnsignedLongLong(rhs)
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return PyLong_AsUnsignedLongLong(lhs) * rhs
    }
    

}

extension Int32 {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLong(Int(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLong(Int(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Int32(PyLong_AsLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int32(PyLong_AsLong(lhs)) * rhs
    }
    

}

extension UInt32 {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLong(UInt(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLong(UInt(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * UInt32(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt32(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    

}

extension Int16 {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLong(Int(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLong(Int(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Int16(PyLong_AsLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int16(PyLong_AsLong(lhs)) * rhs
    }
    

}

extension UInt16 {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLong(UInt(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLong(UInt(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * UInt16(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt16(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    

}

extension Int8 {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLong(Int(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromLong(Int(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromLong(Int(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Int8(PyLong_AsLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Int8(PyLong_AsLong(lhs)) * rhs
    }
    

}

extension UInt8 {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLong(UInt(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyLong_FromUnsignedLong(UInt(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyLong_FromUnsignedLong(UInt(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * UInt8(PyLong_AsUnsignedLong(rhs))
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return UInt8(PyLong_AsUnsignedLong(lhs)) * rhs
    }
    

}

extension Float {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyFloat_FromDouble(Double(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyFloat_FromDouble(Double(lhs)), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(Double(lhs)), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Float(PyFloat_AsDouble(rhs))
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Float(PyFloat_AsDouble(lhs)) * rhs
    }
    

}

extension Double {

    @inlinable static func == (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointer) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyFloat_FromDouble(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointer) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func += (lhs:  PythonPointer, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointer, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs + Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func + (lhs:  PythonPointer, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs - Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func - (lhs:  PythonPointer, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs / Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func / (lhs:  PythonPointer, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointer) -> Self {
        return lhs * Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func * (lhs:  PythonPointer, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) * rhs
    }
    
    @inlinable static func == (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_EQ) == 1
    }
    
    @inlinable static func != (lhs: Self, rhs: PythonPointerU) -> Bool {
        if rhs == nil {
            return PyObject_RichCompareBool(PythonNone, PyFloat_FromDouble(lhs), Py_NE) == 1
        }
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_NE) == 1
    }

    @inlinable static func < (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_LT) == 1
    }

    @inlinable static func <= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_LE) == 1
    }

    @inlinable static func > (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_GT) == 1
    }

    @inlinable static func >= (lhs: Self, rhs: PythonPointerU) -> Bool {
        return PyObject_RichCompareBool(PyFloat_FromDouble(lhs), rhs, Py_GE) == 1
    }


    @inlinable static func += (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func += (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) + rhs
    }
    
    @inlinable static func -= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func -= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) - rhs
    }
    
    @inlinable static func /= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func /= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) / rhs
    }
    
    @inlinable static func *= (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func *= (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) * rhs
    }
    
    @inlinable static func + (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs + Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func + (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) + rhs
    }
    
    @inlinable static func - (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs - Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func - (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) - rhs
    }
    
    @inlinable static func / (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs / Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func / (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) / rhs
    }
    
    @inlinable static func * (lhs:  Self, rhs: PythonPointerU) -> Self {
        return lhs * Double(PyFloat_AsDouble(rhs))
    }
    @inlinable static func * (lhs:  PythonPointerU, rhs: Self) -> Self {
        return Double(PyFloat_AsDouble(lhs)) * rhs
    }
    

}