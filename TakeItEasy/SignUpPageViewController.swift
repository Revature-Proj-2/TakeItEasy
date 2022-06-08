//
//  SignUpPageViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/7/22.
//

import UIKit

class SignUpPageViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordMatchLabel: UILabel!
    @IBOutlet weak var passwordReqText: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailReqText: UILabel!
    @IBOutlet weak var nameReqText: UILabel!
    @IBOutlet weak var reEnterPasswordField: UITextField!
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.delegate = self
        reEnterPasswordField.delegate = self
        phoneNumberField.delegate = self
        emailField.delegate = self
        nameField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
        case passwordField:
            passwordReqText.isHidden = false
        case reEnterPasswordField:
            passwordMatchLabel.isHidden = false
        default:
            print("none")
        }
        
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == reEnterPasswordField{
            if textField.text != passwordField.text {
                passwordMatchLabel.textColor = .red
            }else{
                passwordMatchLabel.textColor = .black
                passwordMatchLabel.text = "Passwords Match"
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case passwordField:
            passwordReqText.isHidden = true
        case nameField:
            if(nameField.text == ""){
                self.nameReqText.isHidden = false
            }else{
                self.nameReqText.isHidden = true
            }
        case emailField:
            if(emailField.text?.range(of: #".+\@.+\..+"#, options: .regularExpression) != nil){
                self.emailReqText.isHidden = true
            }else{
                self.emailReqText.isHidden = false
            }
        default:
            print("none")
        }
    }
    

    
}
