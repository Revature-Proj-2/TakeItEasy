//
//  MusicCollectionViewController.swift
//  TakeItEasy
//
//  Created by Conner Donnelly on 6/14/22.
//

import UIKit
import AVFoundation

class MusicCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {

//    var songs = [
//        Song(title: "Firestorm", artist: "Harry101UK", albumName: "Portal Stories Mel OST", albumImageName: "Temp_Image", url: URL(fileURLWithPath:Bundle.main.path(forResource: "11. Firestorm", ofType: "mp3")!)),
//        Song(title:"Troubled Water",artist:"Harry101UK",albumName:"Portal Stories Mel OST",albumImageName:"Temp_Image",url:URL(fileURLWithPath:Bundle.main.path(forResource: "24. Troubled Water", ofType: "mp3")!)),
//        Song(title: "The Best The World Had To Offer", artist: "Harry101UK", albumName: "Portal Stories Mel OST", albumImageName: "Temp_Image", url: URL(fileURLWithPath:Bundle.main.path(forResource: "35. The Best The World Had To Offer", ofType: "mp3")!))
//    ]
    var songs:[Songs]?
    var deezerURL = "https://api.deezer.com/album/188385452"
    var songsSearch:[Songs]?
    var album:Album?
    var searchAlbum:Album?
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.title = userDefaults.string(forKey:"takeItEasyUserName")
        if let url = URL(string:deezerURL){
            if let data = try? Data(contentsOf: url){
                self.parseData(json: data)
            }
        }
        let storyBoard = UIStoryboard(name:"Music",bundle:nil)
        let musicPlayer = storyBoard.instantiateViewController(withIdentifier: "musicPlayer") as! MusicPlayerViewController
        self.addChild(musicPlayer)
        self.upDateChildViewController(index:0)
        collectionView!.delegate = self
        collectionView!.dataSource = self
//        songsSearch = songs
        searchAlbum = album
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backBarButton = UIBarButtonItem()
        backBarButton.title = "Log Out"
        navigationController?.navigationBar.backItem?.backBarButtonItem = backBarButton
    }
    
    func parseData(json:Data){
        let decoder = JSONDecoder()
        if let jsonAlbum = try? decoder.decode(Album.self,from:json){
//            songs = jsonAlbum.tracks.data
            album = jsonAlbum.self
            print(album!.title)
            print(album!.tracks.data)
            collectionView.reloadData()
        }
            
    }
    
    func upDateChildViewController(index:Int){
//        let model = songs![index]
        let model = album
//        print(model.title)
        let viewModel = MusicPlayerViewModel(title: model!.tracks.data[index].title, artist: model!.artist.name, image: model!.cover,album: model!.title, url: model!.tracks.data[index].preview)
        (self.children.first as! MusicPlayerViewController).vModel = viewModel
        (self.children.first as! MusicPlayerViewController).index = index
        (self.children.first as! MusicPlayerViewController).album = album!
        (self.children.first as! MusicPlayerViewController).initializeData(with: viewModel)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == ""{
//            songs = songsSearch!
            album = searchAlbum
        }else{
            var songs:[Songs] = searchAlbum!.tracks.data
            songs = songs.filter({$0.title.contains(searchBar.text!)})
            print(songs)
            let tracksData = Tracks.init(data: songs)
            album = Album(title: searchAlbum!.title, cover: searchAlbum!.cover, artist: searchAlbum!.artist, tracks: tracksData)
            
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        album!.tracks.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        let model = album
        let cellViewModel = CellViewModel(title: model!.tracks.data[indexPath.row].title, image: model!.cover)
        cell.initalizeCell(with: cellViewModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<Int(album!.tracks.data.count){
            if indexPath.row == index{
                self.upDateChildViewController(index:indexPath.row)
                break
            }
        }
    }
}
