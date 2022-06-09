//
//  SignUpPageViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/7/22.
//

import UIKit

class SignUpPageViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var getOPT: UIButton!
    @IBOutlet weak var phoneReqText: UILabel!
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

    
    func isValidPassword(_ str : String) -> Bool {
        let password = str
        let pswdRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let pswdCheck = NSPredicate(format: "SELF MATCHES %@", pswdRegex)
        return pswdCheck.evaluate(with: password)
    }
    
    func isValidEmail(_ str : String) -> Bool {
        let email = str
        let emailRegex = #".+\@.+\..+"#
        let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailCheck.evaluate(with: email)
    }
    
    func allFieldsFilledOut() -> Bool {
        if(nameField.text != "" && isValidEmail(emailField.text!) && phoneNumberField.text != "" && isValidPassword(passwordField.text!) && passwordField.text == reEnterPasswordField.text){
            return true
        }else{
            return false
        }
    }
    
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
            print("default")
        }
        
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        switch textField{
        case reEnterPasswordField:
            if textField.text != passwordField.text {
                passwordMatchLabel.textColor = .red
            }else{
                passwordMatchLabel.textColor = .black
                passwordMatchLabel.text = "Passwords Match"
            }

        default:
            print("default")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case passwordField:
            if(isValidPassword(passwordField.text!)){
                passwordReqText.textColor = .black
                passwordReqText.isHidden = true
            }else{
                passwordReqText.textColor = .red
            }
        case nameField:
            if(nameField.text == ""){
                nameReqText.isHidden = false
            }else{
                nameReqText.isHidden = true
            }
        case emailField:
            if(emailField.text?.range(of: #".+\@.+\..+"#, options: .regularExpression) != nil){
                emailReqText.isHidden = true
            }else{
                emailReqText.isHidden = false
            }
        case phoneNumberField:
            if(phoneNumberField.text == ""){
                phoneReqText.isHidden = false
            }else{
                phoneReqText.isHidden = true
            }
        default:
            print("none")
        }
    }
    
    @IBAction func getOPTPressed(_ sender: Any) {
        if(allFieldsFilledOut()){
            print("send OTP")
        }else{
            let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in}
            let alert = UIAlertController(title: "Error", message: "All Fields must be filled out", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        }
    }
    
    
}
