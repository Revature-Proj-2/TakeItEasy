//
//  CustomTextField.swift
//  TakeItEasy
//
//  Created by admin on 6/10/22.
//


import UIKit

class CustomTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder){
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 0.45
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.35).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }

}
