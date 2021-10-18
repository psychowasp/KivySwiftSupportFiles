//SwiftyJson Required
//https://github.com/SwiftyJSON/SwiftyJSON
import SwiftyJSON

extension PythonData {
    func asJson(withLength length: Int) -> JSON! {
        return try! JSON(data: self.asData(withLength: length))
    }
}

extension JSON {
    func rawBytes()  -> (bytes: UnsafePointer<UInt8>,size: Int)? {
        do {
            let data = try self.rawData()
            return (data.PythonData, data.count)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


extension Data {
    var asJson: JSON! {
        return try! JSON.init(data: self)
    }
}



extension Collection {
    func toJson() -> String {
        
        guard let json_names = JSON(self).rawString([.castNilToNSNull: true]) else {return ""}
        return json_names
    }
    
    func asJsonBytes() -> (bytes: PythonData, size: Int)! {
        let json = JSON(self)
        return json.rawBytes()
    }
    
    
}
