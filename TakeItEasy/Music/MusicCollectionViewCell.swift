//
//  MusicCollectionViewCell.swift
//  TakeItEasy
//
//  Created by Conner Donnelly on 6/14/22.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    public func initalizeCell(with viewModel:CellViewModel){
        albumImage.image = UIImage(named:viewModel.imageName)
        songTitle.text = viewModel.title
    }
}
