import Foundation

extension String {
    var object: PythonPointer? { PyUnicode_FromString(self) }
}
extension Int {
    var object: PythonPointer? { PyLong_FromLong(self) }
}
extension UInt {
    var object: PythonPointer? { PyLong_FromUnsignedLong(self) }
}
extension Int64 {
    var object: PythonPointer? { PyLong_FromLongLong(self) }
}
extension UInt64 {
    var object: PythonPointer? { PyLong_FromUnsignedLongLong(self) }
}
extension Int32 {
    var object: PythonPointer? { PyLong_FromLong(Int(self)) }
}
extension UInt32 {
    var object: PythonPointer? { PyLong_FromUnsignedLong(UInt(self)) }
}
extension Int16 {
    var object: PythonPointer? { PyLong_FromLong(Int(self)) }
}
extension UInt16 {
    var object: PythonPointer? { PyLong_FromUnsignedLong(UInt(self)) }
}
extension Int8 {
    var object: PythonPointer? { PyLong_FromLong(Int(self)) }
}
extension UInt8 {
    var object: PythonPointer? { PyLong_FromUnsignedLong(UInt(self)) }
}
extension Float {
    var object: PythonPointer? { PyFloat_FromDouble(Double(self)) }
}
extension Double {
    var object: PythonPointer? { PyFloat_FromDouble(self) }
}
