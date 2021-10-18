//
//  WebViewer.swift
//  kivy_swifttest
//
//  Created by macdaw on 01/04/2021.
//

import Foundation
import UIKit
import WebKit
import PDFKit



class WebViewer: UIViewController,WKNavigationDelegate {
    var webview: WKWebView!
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }
    
    func loadURL(path: String) {
        
        let url = URL(string: path)!
        print(url)
        webview.load(URLRequest(url: url))
    }
}


class PDF_Viewer: UIViewController {
    
    let pdfView = PDFView()
    
    override func loadView() {
        //pdfView = PDFView.init()
        self.view = pdfView
    }
    
    func loadPDF(path: String) {
        let filepath = "YourApp/".appending(path)
        print(filepath)
        let url = resourceUrl(forFileName: filepath)!
        let doc = PDFDocument(url: url)
        print(doc as Any)
        self.pdfView.document = doc
        
        
    }
    
    private func resourceUrl(forFileName fileName: String) -> URL? {
        if let resourceUrl = Bundle.main.url(forResource: fileName,
                                             withExtension: "pdf") {
            return resourceUrl
        }
        print("url error")
        return nil
    }
    
}


class KivyUIView: UIView {

    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            print("will add View")
            self.alpha = 0
        }
    }
    
    override func didMoveToSuperview() {
        print("didMoveToSuperview")
        UIView.animate(withDuration: 1) {
            self.alpha = 1
        }
    }
    
}


class DocumentPicker: UIViewController {
    let pick = UIDocumentPickerViewController(documentTypes: [], in: .open)
    //var callback: AppleApiCallback?
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.addSubview(pick.view)
//        if let call = self.callback {
//            if let data = self.view.pixelData() {
//                print(data.size)
//                call.preview_pixel_data(data.bytes, data.size, Int(self.view.bounds.width), Int(self.view.bounds.height))
//            }
//            
//        }
    }
    override func viewDidLoad() {
        
//        if let call = self.callback {
//            if let data = self.view.pixelData() {
//                print(data.size)
//                call.preview_pixel_data(data.bytes, data.size, Int(self.view.bounds.width), Int(self.view.bounds.height))
//            }
//
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
}
