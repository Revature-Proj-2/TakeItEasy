//
//  NotesCollectionViewCell.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    static let identifier = "NotesCollectionViewCell"
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateFormatter.dateFormat = "dd.MM.yyyy"
    }
    public func configure(with text: String, date: Date){
        labelView.numberOfLines = 0
        labelView.text = text
        dateView.text = dateFormatter.string(from: date)
    }
    static func nib() -> UINib{
        return UINib.init(nibName: identifier, bundle: nil)
    }

}
