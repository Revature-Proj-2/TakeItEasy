//
//  QuizTableViewCell.swift
//  TakeItEasy
//
//  Created by xcode on 6/15/22.
//

import UIKit
import Foundation
class QuizTableViewCell: UITableViewCell {
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

    @IBOutlet weak var qui3S: UILabel!
    @IBOutlet weak var quiz4: UILabel!
    
    @IBOutlet weak var quiz1S: UILabel!
    
    @IBOutlet weak var quiz2S: UILabel!
}
