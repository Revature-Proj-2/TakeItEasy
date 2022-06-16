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
        let url = URL(string: viewModel.image)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            albumImage.image = UIImage(data: imageData)
        }
        songTitle.text = viewModel.title
    }
}
