
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
    
    var PythonData: PythonData {
        self.withUnsafeBytes { (unsafeBytes) in
            let bytes = unsafeBytes.bindMemory(to: UInt8.self).baseAddress!
            return bytes
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

extension PythonString {
    func asString() -> String {
        return String(cString: self )
    }
}

extension PythonBytes {

}


extension PythonData {
    func asData(withLength length: Int) -> Data {
        return Data(UnsafeBufferPointer(start: self, count: length))
    }
}



extension PythonJsonData {
    func asDictionary(count: Int, options: JSONSerialization.ReadingOptions = .mutableContainers) -> [String:Any]! {
        let data = self.asData(count: count)
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: options) as! [String:Any]
            return dict
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func asArray(count: Int, options: JSONSerialization.ReadingOptions = .mutableContainers) -> [Any]! {
        let data = self.asData(count: count)
        do {
            let array = try JSONSerialization.jsonObject(with: data, options: options) as! [Any]
            return array
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


func pythonJSONBytes(object: Any) -> PythonData? {
    do {
        let bytes = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed).PythonData
        return bytes
    } catch {
        print(error.localizedDescription)
    }
    return nil
}






