//
//  BookSearchTableViewCell.swift
//  TakeItEasy
//
//  Created by admin on 6/19/22.
//

import UIKit

class BookSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookDesc: UILabel!
    
    static let identifier = "BookSearchTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bookImage.layer.cornerRadius = 10
        bookTitle.numberOfLines = 2
        bookDesc.numberOfLines = 0
        bookTitle.sizeToFit()
        bookDesc.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib.init(nibName: identifier, bundle: nil)
    }
    
}
