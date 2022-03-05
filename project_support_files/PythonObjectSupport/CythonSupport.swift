
import Foundation


extension UnsafePointer where Pointee == UInt8 {
    func asArray(count: Int) -> [UInt8] {
        return Array(UnsafeBufferPointer(start: self, count: count))
        
    }
    func asData(count: Int) -> Data {
        return Data(UnsafeBufferPointer(start: self, count: count))
    }
}

func pointer2array<T>(data: UnsafePointer<T>,count: Int) -> [T] {
    let buffer = UnsafeBufferPointer(start: data, count: count);
    return Array<T>(buffer)
}



extension Data {
    var bytes_array : [UInt8] {
        return [UInt8](self)
    }
    
//    var bytes : UnsafePointer<UInt8> {
//        self.withUnsafeBytes { (unsafeBytes) in
//            let bytes = unsafeBytes.bindMemory(to: UInt8.self).baseAddress!
//            return bytes
//        }
//    }
    
    var pythonData: PythonData {
        self.withUnsafeBytes { (unsafeBytes) in
            let bytes = unsafeBytes.bindMemory(to: UInt8.self).baseAddress!
            return PythonData(ptr: bytes, size: self.count)
        }
    }
    
    var pythonJsonData: PythonJsonData {
        self.withUnsafeBytes { (unsafeBytes) in
            let bytes = unsafeBytes.bindMemory(to: UInt8.self).baseAddress!
            return PythonJsonData(ptr: bytes, size: self.count)
        }
    }
}


extension Array {
    func unsafePointer<T>() -> UnsafePointer<T> {
        self.withUnsafeBytes { (unsafeBytes) in
            let bytes = unsafeBytes.bindMemory(to: T.self).baseAddress!
            return bytes
        }
    }
}




//Python/C Types

extension String {
    var pythonString: PythonString {
        return self.cString(using: .utf8)!.unsafePointer()
    }
}

extension PythonString {
    var string: String {
        return String(cString: self )
    }
}

extension PythonBytes {

}

extension PythonData {
    var data: Data {
        return Data(UnsafeBufferPointer(start: self.ptr, count: self.size))
    }
}



extension PythonJsonData {
    
    var data: Data {
        return Data(UnsafeBufferPointer(start: self.ptr, count: self.size))
    }
    
    func dictionary(options: JSONSerialization.ReadingOptions = .mutableContainers) -> [String:Any]! {
        let data = self.data
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: options) as! [String:Any]
            return dict
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func array(options: JSONSerialization.ReadingOptions = .mutableContainers) -> [Any]! {
        let data = self.data
        do {
            let array = try JSONSerialization.jsonObject(with: data, options: options) as! [Any]
            return array
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

func pythonList_PythonString(strings: [PythonString]) -> PythonList_PythonString {
    //let list_pystr = self.map{$0.pythonString}
    let rtn = PythonList_PythonString(ptr: strings, size: strings.count)
    return rtn
}

extension Array where Element == String {
    
}

extension PythonList_PythonString {
    
    func asArray(length: CLong) -> [String] {
        var strings: [String] = []
        for i in 0..<length {
            strings.append(String(cString: self.ptr[i]))
        }
        return strings
    }
}

func pythonJSONBytes(object: Any) -> PythonData? {
    do {
        let bytes = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed).pythonData
        return bytes
    } catch {
        print(error.localizedDescription)
    }
    return nil
}








import CoreFoundation

class ParkBenchTimer {

    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()

        return duration!
    }

    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return (endTime - startTime) * 1_000
        } else {
            return nil
        }
    }
}




func list_for_loop(list: PythonPointer) {
    
}

func list_mapping(list: PythonPointer, list2: PythonPointer) -> [Int] {
//    let timer0 = ParkBenchTimer()
    let array = list.map{$0.int}
//    let stop0 = timer0.stop()
//    print("mapping of list[int] took \(stop0) us.")
//    let timer1 = ParkBenchTimer()
    let _ = list2.map{$0.int}
//    let stop1 = timer1.stop()
//    print("mapping of tuple[int] took \(stop1) us.")
//    let timer2 = ParkBenchTimer()
    let _ = list.map{$0.uint8}
//    let stop2 = timer2.stop()
//    print("mapping of list[uint8] took \(stop2) us.")
//    let timer3 = ParkBenchTimer()
    let _ = list2.map{$0.uint8}
//    let stop3 = timer3.stop()
//    print("mapping of tuple[uint8] took \(stop3) us.")
    return array
}

func test_dictionary(dict: PythonPointer?) -> Int {
    var key: [PythonPointer?] = []
    var value: [PythonPointer?] = []
    var pos: Py_ssize_t = 0

    while (PyDict_Next(dict, &pos, &key, &value) != 0) {
        let i = PyLong_AsLong(value.first!)
        if i == -1 && (PyErr_Occurred() != nil) {
            return -1
        }
        let o = PyLong_FromLong(i + 1)
        if o == nil {
            return -1
        }
        if PyDict_SetItem(dict, key.first!, o) < 0 {
            Py_DecRef(o)
            return -1
        }
        Py_DecRef(o)
    }
    return 0
}


