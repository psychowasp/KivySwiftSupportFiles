
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

func test_dictionary(dict: PythonPointer) -> Int {
    var key: [PythonPointer] = []
    var value: [PythonPointer] = []
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


