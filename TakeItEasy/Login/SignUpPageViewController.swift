//
//  SignUpPageViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/7/22.
//

import UIKit
import CoreData

class SignUpPageViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signUpButton: UIButton!
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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
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
            signUpButton.isEnabled = true
            print("send OTP")
        }else{
            let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in}
            let alert = UIAlertController(title: "Error", message: "All Fields must be filled out", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        }
    }
    
    func createUser(_ userName : String){
        do{
            let request = User.fetchRequest() as NSFetchRequest<User>
            let pred = NSPredicate(format: "userName == %@", userName)
            request.predicate = pred
            let userArr = try context.fetch(request)
            let user = userArr.first
            if (user?.userName != nil) {
                return
            }else{
                let newUser = User(context: context)
                newUser.userName = userName
                newUser.email = emailField.text
                newUser.phoneNumber = Int16(Int(phoneNumberField.text!) ?? 0)
                do{
                    try context.save()
                }catch{
                    print("error saving User")
                }
                print("new user created")
            }
        }catch{
            print("Error fetching user")
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : nameField.text!, kSecValueData as String : passwordField.text!.data(using: .utf8)!]
        if SecItemAdd(attribute as CFDictionary, nil) == noErr {
            createUser(nameField.text!)
            let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in
                self.navigationController?.popViewController(animated: true)
            }
            let alert = UIAlertController(title: "Sign up Successful", message: "Please log in with your credentials", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
            
        }else{
            let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in}
            let alert = UIAlertController(title: "Error", message: "An error has occurred", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        }
    }
    
}
