//
//  GIL.swift
//


import Foundation

@inlinable
func withGIL(handle: @escaping ()->Void ) {
    let gil = PyGILState_Ensure()
    handle()
    PyGILState_Release(gil)
}


extension DispatchQueue {
    
    @inlinable
    func withGIL(handle: @escaping ()->Void ) {
        self.async {
            let gil = PyGILState_Ensure()
            handle()
            PyGILState_Release(gil)
        }
    }
}
