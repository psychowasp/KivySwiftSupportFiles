//
//  PythonBuffer+AutoDecRef.swift
//  metacam
//
//  Created by MusicMaker on 01/03/2022.
//

import Foundation


class PythonPointerAutoRelease {
    let ptr: PythonPointer?
    private let keep: Bool
    init(pointer: PythonPointer?, keep: Bool = true, from_getattr: Bool = false) {
        ptr = pointer
        if from_getattr {
            self.keep = true
            //print("from getattr \(ptr!) ref count is now \(ptr!.pointee.ob_refcnt)")
        } else {
            self.keep = keep
            
            if keep {
                Py_IncRef(pointer)
                //print("keeping \(ptr!) ref count is now \(ptr!.pointee.ob_refcnt)")
            }
        }
        
    }
    
    deinit {
        if keep {
            Py_DecRef(ptr)
            //print("deinit \(ptr!) ref count is now \(ptr!.pointee.ob_refcnt)")
        }
    }
}
