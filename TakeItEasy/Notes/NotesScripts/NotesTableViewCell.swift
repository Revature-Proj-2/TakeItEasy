//
//  NotesTableViewCell.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    
    static let identefier = "NotesTableViewCell"
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateFormatter.dateFormat = "dd/MM/yyyy  hh:mm"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        // Configure the view for the selected state
    }
    
    public func configure(with text: String, date: Date){
        titleView.text = text
        dateView.text = dateFormatter.string(from: date)
    }
    
    
    static func nib() -> UINib{
        return UINib.init(nibName: identefier, bundle: nil)
    }
    
}
