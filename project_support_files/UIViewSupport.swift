//
//  UIViewSupport.swift
//  test
//
//  Created by MusicMaker on 24/09/2021.
//

import Foundation
import UIKit



func get_viewcontroller() -> UIViewController? {
    let window = UIApplication.shared.windows.first
    if window == nil {
        print("ios_wrapper: unable to get key window from shared application\n")
        return nil
    }
    return window!.rootViewController
}

func showPopup(view: UIViewController) {
    guard let controller = get_viewcontroller() else {return}
    controller.present(view, animated: true, completion: nil)
}



func xibToDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]
    if let xib = Bundle.main.loadNibNamed("View", owner: nil, options: nil) {
        for item in xib {
            switch item {
            case let view as UIView:
                if let id = view.accessibilityIdentifier {
                    print(id)
                    dict[id] = item
                }
                
            case let controller as UIViewController:
                if let id = controller.nibName {
                    print(id)
                    dict[id] = controller
                }
            default:
                print("not supported", item)
            }
        }
    }
    
    return dict
}

func image(with view: UIView?) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view?.bounds.size ?? CGSize.zero, view?.isOpaque ?? false, 0.0)
    if let context = UIGraphicsGetCurrentContext() {
        view?.layer.render(in: context)
    }

    let img = UIGraphicsGetImageFromCurrentImageContext()

    UIGraphicsEndImageContext()

    return img
}

extension UIView {
    func removeSelf() {
        UIView.animate(withDuration: 1) {
            self.alpha = 0
        } completion: { finished in
            self.removeFromSuperview()
        }
    }
}

extension UIImage {
    func pixelData() -> [UInt8]? {
        let size = self.size
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let cgImage = self.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        return pixelData
    }
 }


extension UIView {
    func pixelData() -> (bytes: [UInt8], size: Int)? {
        let size = self.bounds
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) {
            
            self.layer.render(in: context)
            return (pixelData,Int(dataSize))
        }
        return nil
    }
 }

struct KivyTextureData {
    var data: UnsafeMutablePointer<UInt8>
    var size: Int
    var width: Int
    var height: Int
}


extension CVPixelBuffer {
    func TextureData() -> (data: UnsafeMutablePointer<UInt8>, data_size: Int , width: Int, height: Int){
        CVPixelBufferLockBaseAddress(self, [])
        let width = CVPixelBufferGetWidth(self)
        let height = CVPixelBufferGetHeight(self)
        let src_buff = CVPixelBufferGetBaseAddress(self)
        CVPixelBufferUnlockBaseAddress(self, [])
        let buf = src_buff!.assumingMemoryBound(to: UInt8.self)
        return (buf, CVPixelBufferGetDataSize(self), width ,height)
    }
    
    func rawBytes() -> (data: UnsafeMutablePointer<UInt8>, data_size: Int) {
        CVPixelBufferLockBaseAddress(self, [])
        let src_buff = CVPixelBufferGetBaseAddress(self)
        CVPixelBufferUnlockBaseAddress(self, [])
        return (src_buff!.assumingMemoryBound(to: UInt8.self), CVPixelBufferGetDataSize(self))
    }
}
