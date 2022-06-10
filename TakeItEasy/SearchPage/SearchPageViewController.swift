//
//  SearchPageViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/10/22.
//

import UIKit
import WebKit

class SearchPageViewController: UIViewController {

   
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: "https:www.google.com")!))
        
    }
    
    
    

}
