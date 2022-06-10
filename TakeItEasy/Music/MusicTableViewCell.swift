//
//  MusicTableViewCell.swift
//  TakeItEasy
//
//  Created by admin on 6/9/22.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    static let cellIdentifier = "songCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func getNib() -> UINib{
        let currentNib = UINib(nibName: "MusicTableView", bundle: nil)
        return currentNib //UINib(nibName: "MusicTableView", bundle: nil)
    }
    public func initalizeCell(_ imageName:String, songTitle:String, artist:String){
        albumImage.image = UIImage(named: imageName)
        self.songTitle.text = songTitle
        self.artist.text = artist
    }
    public func initalizeCell(with viewModel: CellViewModel){
        albumImage.image = UIImage(named:viewModel.imageName)
        songTitle.text = viewModel.title
        artist.text = viewModel.artist
    }
    
}
