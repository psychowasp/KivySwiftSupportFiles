//
//  PythonPointer+Subscript.swift
//  metacam
//
//  Created by MusicMaker on 26/02/2022.
//

import Foundation
import CoreGraphics


//extension PythonPointer: Collection {
// 
//    
//    public func index(after i: Int) -> Int {
//        0
//    }
//
//    public typealias Index = Int
//    public var startIndex: Int {
//        0
//    }
//    
//    public var endIndex: Int {
//        PyList_Size(self)
//    }
//    @inlinable
//    public subscript(position: Int) -> PythonPointer {
//        
//        get {
//            if PythonList_Check(self) { PyList_GetItem(self, position) }
//            if PythonTuple_Check(self) { PyTuple_GetItem(self, position)}
//                // Return an appropriate subscript value here.
//            return PythonNone
//            }
//            
//        set {
//            // Perform a suitable setting action here.
//            if PythonList_Check(self) { PyList_SetItem(self, position, newValue) }
//            if PythonTuple_Check(self) { PyTuple_SetItem(self, position, newValue)}
//        }
//    
//    }
//    
//    


extension PythonPointer {


       
//    @inlinable
//    public subscript(index: String) -> PythonPointer? {
//        
//        get {
//            if PythonDict_Check(self) { PyDict_GetItemString(self, index) }
//            return nil
//                // Return an appropriate subscript value here.
//            }
//        set {
//            // Perform a suitable setting action here.
//            if PythonDict_Check(self) { PyDict_SetItemString(self, index, newValue) } else {
//                print("\(self)")
//            }
//        }
//    
//    }
    
    @inlinable
    subscript(index: String) -> PythonPointer {
        
        get {
            if PythonDict_Check(self) { return PyDict_GetItemString(self, index)! }
            fatalError()
                // Return an appropriate subscript value here.
            }
        set {
            // Perform a suitable setting action here.
            if PythonDict_Check(self) { PyDict_SetItemString(self, index, newValue) } else {
                print("\(String(describing: self))")
            }
        }
    
    }
    
//    @inlinable
//    subscript(index: PythonPointer?) -> PythonPointer? {
//        
//        get {
//            if PythonDict_Check(self) { PyDict_GetItem(self, index) }
//            return nil
//                // Return an appropriate subscript value here.
//            }
//        set {
//            // Perform a suitable setting action here.
//            if PythonDict_Check(self) { PyDict_SetItem(self, index, newValue) } else {
//                print("\(self)")
//            }
//        }
//    
//    }
}

extension PythonPointer {
    func append(_ value: Int) { PyList_Append(self, value.python_int) }
    func append(_ value: UInt) { PyList_Append(self, value.python_int) }
    func append<T: SignedInteger>(_ value: T) { PyList_Append(self, value.python_int) }
    func append<T: UnsignedInteger>(_ value: T) { PyList_Append(self, value.python_int) }
    //func append(_ value: String) { PyList_Append(self, value.python_str) }
    func append(_ value: Double) { PyList_Append(self, value.python_float) }
    func append(_ value: Float) { PyList_Append(self, value.python_float) }
    @available(iOS 14, *)
    func append(_ value: Float16) { PyList_Append(self, value.python_float) }
    func append(_ value: CGFloat) { PyList_Append(self, value.python_float) }
    
    
    //Content of:
    func append(contentsOf: [Int]) {
        for value in contentsOf { PyList_Append(self, value.python_int) }
    }
    func append(contentsOf: [UInt]) {
        for value in contentsOf { PyList_Append(self, value.python_int) }
    }
    
    func append<T: SignedInteger>(contentsOf: [T]) {
        for value in contentsOf { PyList_Append(self, value.python_int) }
    }
    func append<T: UnsignedInteger>(contentsOf: [T]) {
        for value in contentsOf { PyList_Append(self, value.python_int) }
    }
    
    func append(contentsOf: [Double]) {
        for value in contentsOf { PyList_Append(self, value.python_float) }
    }
    
    func append(contentsOf: [Float]) {
        for value in contentsOf { PyList_Append(self, value.python_float) }
    }
    @available(iOS 14, *)
    func append(contentsOf: [Float16]) {
        for value in contentsOf { PyList_Append(self, value.python_float) }
    }
    func append(contentsOf: [CGFloat]) {
        for value in contentsOf { PyList_Append(self, value.python_float) }
    }
    func append(contentsOf: Data) {
        for value in contentsOf { PyList_Append(self, value.python_int) }
    }
    func append(contentsOf: [String]) {
        //for value in contentsOf { PyList_Append(self, value.python_str) }
    }
    func append(contentsOf: [PythonPointer]) {
        for value in contentsOf { PyList_Append(self, value) }
    }
    
    
//    @inlinable public mutating func insert(_ newElement: PythonPointer?, at i: Int) {
//        PyList_Insert(self, i, newElement)
//    }
    
    @inlinable public mutating func insert(_ newElement: PythonPointer, at i: Int) {
        PyList_Insert(self, i, newElement)
    }
    
    @inlinable public mutating func insert(_ newElement: String, at i: Int) {
        PyList_Insert(self, i, PyUnicode_FromString(newElement))
    }
    
    @inlinable public mutating func insert(_ newElement: Int, at i: Int) {
        PyList_Insert(self, i, PyLong_FromLong(newElement))
    }
    
    @inlinable public mutating func insert(_ newElement: UInt, at i: Int) {
        PyList_Insert(self, i, PyLong_FromUnsignedLong(newElement))
    }
    
    @inlinable public mutating func insert<T: SignedInteger>(_ newElement: T, at i: Int) {
        PyList_Insert(self, i, PyLong_FromLong(Int(newElement)))
    }
    
    @inlinable public mutating func insert<T: UnsignedInteger>(_ newElement: T, at i: Int) {
        PyList_Insert(self, i, PyLong_FromUnsignedLong(UInt(newElement)))
    }
    
    @inlinable public mutating func insert(_ newElement: Double, at i: Int) {
        PyList_Insert(self, i, PyFloat_FromDouble(newElement))
    }
    
    @inlinable public mutating func insert(_ newElement: Float, at i: Int) {
        PyList_Insert(self, i, PyFloat_FromDouble(Double(newElement)))
    }
    
    @inlinable public mutating func insert(_ newElement: CGFloat, at i: Int) {
        PyList_Insert(self, i, PyFloat_FromDouble(newElement))
    }
    
    @available(iOS 14, *)
    @inlinable public mutating func insert(_ newElement: Float16, at i: Int) {
        PyList_Insert(self, i, PyFloat_FromDouble(Double(newElement)))
    }
    
    @inlinable public mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, Element == C.Element {
        for element in newElements {
            PyList_Insert(self, i, element)
        }
    }
    
    @inlinable public mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, C.Element == String {
        for element in newElements {
            PyList_Insert(self, i, PyUnicode_FromString(element))
        }
    }
    
    @inlinable public mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, C.Element == Int {
        for element in newElements {
            PyList_Insert(self, i, PyLong_FromLong(element))
        }
    }
    
    @inlinable public mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, C.Element == UInt {
        for element in newElements {
            PyList_Insert(self, i, PyLong_FromUnsignedLong(element))            
        }
    }
    
    @inlinable public mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, C.Element == Int32 {
        for element in newElements {
            PyList_Insert(self, i, PyLong_FromLong(Int(element)))
        }
    }
    
    @inlinable public mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, C.Element == UInt32 {
        for element in newElements {
            PyList_Insert(self, i, PyLong_FromUnsignedLong(UInt(element)))
        }
    }
    
    //func append(_ value: Int) { PyList_Append(self, value.python_int) }
    
    
    
    
    func callTest() {
        let array = [Int]()
        //self.callAsFunction(1.python_int,2.python_int,3.python_int,4.python_int)
    }
}


