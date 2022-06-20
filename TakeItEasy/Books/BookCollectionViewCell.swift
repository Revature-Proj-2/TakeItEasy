//
//  BookCollectionViewCell.swift
//  TakeItEasy
//
//  Created by admin on 6/15/22.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    
    static let identifier = "BookCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bookImage.layer.cornerRadius = 10
        bookName.numberOfLines = 2
        bookName.sizeToFit()
    }

    static func nib() -> UINib{
        return UINib.init(nibName: identifier, bundle: nil)
    }
}
