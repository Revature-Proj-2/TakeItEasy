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
    @IBOutlet weak var imageView: UIImageView!

    
    static let identifier = "NotesCollectionViewCell"
    
    
    var needsDeletion : (()->())?
    let dateFormatter = DateFormatter()
    var isChecked = Bool(){
        didSet{
            if(!isChecked){
                deleteIcon.setImage(UIImage(systemName: "square"),for: .normal)
            }else{
                deleteIcon.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
            }
        }
        
    }
    var cellIndex = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        imageView.layer.cornerRadius = 20
        
        isChecked = false
        setupViews()
    }
    public func configure(with text: String, date: Date, indexPath: IndexPath){
        labelView.numberOfLines = 0
        dateView.numberOfLines = 0
        
        cellIndex = IndexPath()
        labelView.text = text
        dateView.text = dateFormatter.string(from: date)
        isChecked = false
    }
    
    func deleteBox(){
        deleteIcon.isHidden = false
    }
    func deleteBoxHidden(){
        deleteIcon.isHidden = true
    }
    
    
    static func nib() -> UINib{
        return UINib.init(nibName: identifier, bundle: nil)
    }
    
    
    let deleteIcon: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
           button.translatesAutoresizingMaskIntoConstraints = true
           button.setImage(UIImage(systemName: "square"),for: .normal)
           return button
       }()

       func setupViews(){

           // add a button
           addSubview(deleteIcon)

            deleteIcon.frame = CGRect(x: 5, y: 5, width: 20, height: 20)

           // add the touchUpInside target
           deleteIcon.addTarget(self, action: #selector(deleteItems), for: .touchUpInside)

       }
    
    
    
    @objc func deleteItems(){
        isChecked = !isChecked
        needsDeletion?()
    }

}
