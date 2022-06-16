//
//  SearchPageViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/10/22.
//

import UIKit
import WebKit

class SearchPageViewController: UIViewController {

    let userDefault = UserDefaults.standard
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("search page view did appear")
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = "Log Out"
        navigationController?.navigationBar.backItem?.backBarButtonItem = backBarBtnItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.title = userDefault.string(forKey: "takeItEasyUserName")
        webView.load(URLRequest(url: URL(string: "https:www.google.com")!))
    }
    
    
    
    

}
