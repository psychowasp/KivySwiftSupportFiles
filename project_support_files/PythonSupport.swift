
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
    
    var asPythonData: PythonData {
        self.withUnsafeBytes { (unsafeBytes) in
            let bytes = unsafeBytes.bindMemory(to: UInt8.self).baseAddress!
            return PythonData(ptr: bytes, size: self.count)
        }
    }
    
    var asPythonJsonData: PythonJsonData {
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
    var asPythonString: PythonString {
        return "".cString(using: .utf8)!.unsafePointer()
    }
}

extension PythonString {
    func asString() -> String {
        return String(cString: self )
    }
}

extension PythonBytes {

}


extension PythonData {
    var asData: Data {
        return Data(UnsafeBufferPointer(start: self.ptr, count: self.size))
    }
}



extension PythonJsonData {
    
    var asData: Data {
        return Data(UnsafeBufferPointer(start: self.ptr, count: self.size))
    }
    
    func asDictionary(options: JSONSerialization.ReadingOptions = .mutableContainers) -> [String:Any]! {
        let data = self.asData
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: options) as! [String:Any]
            return dict
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func asArray(options: JSONSerialization.ReadingOptions = .mutableContainers) -> [Any]! {
        let data = self.asData
        do {
            let array = try JSONSerialization.jsonObject(with: data, options: options) as! [Any]
            return array
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension PythonList_PythonString {
    
    func asArray(length: CLong) -> [String] {
        var strings: [String] = []
        for i in 0..<length {
            strings.append(self.ptr[i].asString())
        }
        return strings
    }
}

func pythonJSONBytes(object: Any) -> PythonData? {
    do {
        let bytes = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed).asPythonData
        return bytes
    } catch {
        print(error.localizedDescription)
    }
    return nil
}






