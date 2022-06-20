//
//  LoginPageViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/7/22.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    let userDefault = UserDefaults.standard
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefault.string(forKey: "takeItEasyRememberMe") == "yes"{
            rememberMeSwitch.setOn(true, animated: true)
            userNameField.text = userDefault.string(forKey: "takeItEasyUserName")
            let req : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : userNameField.text!, kSecReturnAttributes as String : true, kSecReturnData as String : true]

            var res : CFTypeRef?
            if SecItemCopyMatching(req as CFDictionary, &res) == noErr{
                let data = res as? [String : Any]
                let userPassword = (data![kSecValueData as String] as? Data)!
                let pass = String(data: userPassword, encoding: .utf8)
                passwordField.text = pass
            }
        }
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        let req : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : userNameField.text!, kSecReturnAttributes as String : true, kSecReturnData as String : true]
        var res : CFTypeRef?
        if SecItemCopyMatching(req as CFDictionary, &res) == noErr{
            let data = res as? [String : Any]
            let userName = (data![kSecAttrAccount as String] as? String)!
            let userPassword = (data![kSecValueData as String] as? Data)!
            let pass = String(data: userPassword, encoding: .utf8)
            if passwordField.text == pass {
                userDefault.set(userName, forKey: "takeItEasyCurrentLoggedIn")
                if rememberMeSwitch.isOn {
                    userDefault.set("yes", forKey: "takeItEasyRememberMe")
                    userDefault.set(userName, forKey: "takeItEasyUserName")
                }else{
                    userDefault.set("no", forKey: "takeItEasyRememberMe")
                    userDefault.set("", forKey: "takeItEasyUserName")
                }
                let storyBoard = UIStoryboard(name: "TabController", bundle: nil)
                let page = storyBoard.instantiateViewController(withIdentifier: "Controller")
                show(page, sender: Any?.self)
            }
            else{
                let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in}
                let alert = UIAlertController(title: "Error", message: "An error has occurred", preferredStyle: .alert)
                alert.addAction(defaultAction)
                self.present(alert, animated: true)
            }
        }else{
            let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in}
            let alert = UIAlertController(title: "Error", message: "An error has occurred", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        }
    }
    

}
