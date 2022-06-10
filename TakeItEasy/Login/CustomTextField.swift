//
//  CustomTextField.swift
//  TakeItEasy
//
//  Created by admin on 6/10/22.
//

import Foundation
import UIKit

class CustomTextField: UITextField {

    convenience init() {
        self.init(frame: .zero)
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: frame.size.height)
        //border.cornerRadius = 20
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }

}
