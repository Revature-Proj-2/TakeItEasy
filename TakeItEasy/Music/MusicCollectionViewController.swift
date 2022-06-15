//
//  MusicCollectionViewController.swift
//  TakeItEasy
//
//  Created by Conner Donnelly on 6/14/22.
//

import UIKit
import AVFoundation

class MusicCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {

    var songs = [
        Song(title: "Firestorm", artist: "Harry101UK", albumName: "Portal Stories Mel OST", albumImageName: "Temp_Image", mediaSource: "YouTube", url: URL(fileURLWithPath:Bundle.main.path(forResource: "11. Firestorm", ofType: "mp3")!)),
        Song(title:"Troubled Water",artist:"Harry101UK",albumName:"Portal Stories Mel OST",albumImageName:"Temp_Image",mediaSource:"YouTube",url:URL(fileURLWithPath:Bundle.main.path(forResource: "24. Troubled Water", ofType: "mp3")!)),
        Song(title: "The Best The World Had To Offer", artist: "Harry101UK", albumName: "Portal Stories Mel OST", albumImageName: "Temp_Image", mediaSource: "YouTube", url: URL(fileURLWithPath:Bundle.main.path(forResource: "35. The Best The World Had To Offer", ofType: "mp3")!))
    ]
    var songsSearch:[Song]?
//    var collectionView : UICollectionView?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = songs[0]
        print(model.title)
        let viewModel = MusicPlayerViewModel(title: model.title, artist: model.artist, imageName: model.albumImageName,source: model.mediaSource, url: model.url)
        let storyBoard = UIStoryboard(name:"Music",bundle:nil)
        let musicPlayer = storyBoard.instantiateViewController(withIdentifier: "musicPlayer") as! MusicPlayerViewController
        self.addChild(musicPlayer)
        self.upDateChildViewController(index:0)
        songsSearch = songs
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
    }
    func upDateChildViewController(index:Int){
        let model = songs[index]
        print(model.title)
        let viewModel = MusicPlayerViewModel(title: model.title, artist: model.artist, imageName: model.albumImageName,source: model.mediaSource, url: model.url)
        (self.children.first as! MusicPlayerViewController).vModel = viewModel
        (self.children.first as! MusicPlayerViewController).index = index
        (self.children.first as! MusicPlayerViewController).songs = songs
        (self.children.first as! MusicPlayerViewController).initializeData(with: viewModel)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == ""{
            songs = songsSearch!
        }else{
            songs = songsSearch!.filter({$0.title.contains(searchBar.text!)})
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        let model = songs[indexPath.row]
        let cellViewModel = CellViewModel(title: model.title, artist: model.artist, imageName: model.albumImageName)
        cell.initalizeCell(with: cellViewModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<Int(songs.count){
            if indexPath.row == index{
                self.upDateChildViewController(index:indexPath.row)
                break
            }
        }
    }
}
