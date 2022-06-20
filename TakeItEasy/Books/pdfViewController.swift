//
//  pdfViewController.swift
//  funZone
//
//  Created by admin on 6/4/22.
//

import UIKit
import PDFKit
import WebKit

class pdfViewController: UIViewController{
    
    let webView = WKWebView()
    var book = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("transition")
        view.addSubview(webView)

        guard let url = URL(string: book) else{
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = CGRect(x: -180, y: -70, width: view.bounds.width + 200, height: view.bounds.height)
        }
    
}
