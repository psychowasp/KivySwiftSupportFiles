//SwiftyJson Required
//https://github.com/SwiftyJSON/SwiftyJSON
import SwiftyJSON
import Foundation

extension PythonData {
    func asJson(withLength length: Int) -> JSON! {
        return try! JSON(data: self.data)
    }
}

extension JSON {
    func rawBytes()  -> PythonJsonData? {
        do {
            let data = try self.rawData()
            return data.pythonJsonData
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
    
    func asJsonBytes() -> PythonJsonData! {
        let json = JSON(self)
        return json.rawBytes()
    }
    
    func asData() -> Data {
        let json = JSON(self)
        return try! json.rawData()
    }
    
    
}
