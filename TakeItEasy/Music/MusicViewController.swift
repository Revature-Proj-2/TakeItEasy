//
//  MusicViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/9/22.
//

import UIKit
import CoreData

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //@IBOutlet weak var musicTable: UITableView!
    //@IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var musicTable: UITableView!
//    var songTitle : [String] = ["Temp Title","Temp Title"] //Temp Data for testing
//    var artist : [String] = ["Temp Artist","Temp Artist"] //Temp Data for testing
//    var albumImage:[String] = ["Temp_Image","Temp_Image"]
    var songs = [
        Song(title: "Firestorm", artist: "Harry101UK", albumName: "Portal Stories Mel", albumImageName: "Temp_Image", mediaSource: "YouTube", url: URL(fileURLWithPath:Bundle.main.path(forResource: "11. Firestorm", ofType: "mp3")!)),
        Song(title:"Troubled Water",artist:"Harry101UK",albumName:"Portal Stories Mel",albumImageName:"Temp_Image",mediaSource:"YouTube",url:URL(fileURLWithPath:Bundle.main.path(forResource: "24. Troubled Water", ofType: "mp3")!)),
                
        Song(title: "The Best The World Had To Offer", artist: "Harry101UK", albumName: "Portal Stories Mel OST", albumImageName: "Temp_Image", mediaSource: "YouTube", url: URL(fileURLWithPath:Bundle.main.path(forResource: "35. The Best The World Had To Offer", ofType: "mp3")!))
    ]
    var songsPlayList = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        //let tableNib = UINib(nibName: "MusicViewController", bundle: nil)
//        songsPlayList.set(songs, forKey: "songData")
        musicTable.dataSource = self
        musicTable.delegate = self
        let cellNib = UINib(nibName: "MusicTableViewCell", bundle: nil)
        musicTable.register(cellNib, forCellReuseIdentifier: "songCell")//MusicTableViewCell.cellIdentifier)
//        let cellNib = MusicTableViewCell.nib()
//        musicTable.register(nibName: "MusicTableViewCell", forCellReuseIdentifier: MusicTableViewCell.cellIdentifier)
//        var cellNib:UINib = MusicTableViewCell.nib( )
    }
    override func loadView() {
        super.loadView()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! MusicTableViewCell
        let model = songs[indexPath.row]
        print(model.title)
        let veiwModel = CellViewModel(title:model.title,artist:model.artist,imageName:model.albumImageName)
        print(veiwModel.title)
        cell.initalizeCell(with: veiwModel)
//        cell.initalizeCell(<#T##imageName: String##String#>, songTitle: <#T##String#>, artist: <#T##String#>)
        
//        cell.initalizeCell(albumImage[indexPath.row], songTitle: songTitle[indexPath.row], artist: artist[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index in 0..<Int(songs.count)
        {
            if indexPath.row == index{
                print("the indexPath.row is \(indexPath.row)")
                let model = songs[indexPath.row]
                let viewModel = MusicPlayerViewModel(title: model.title, artist: model.artist, imageName: model.albumImageName, url:model.url)
                let storyBoard = UIStoryboard(name:"Music",bundle:nil)
                let musicPlayer = storyBoard.instantiateViewController(withIdentifier: "musicPlayer") as! MusicPlayerViewController
                musicPlayer.vModel = viewModel
                musicPlayer.index = indexPath.row
                musicPlayer.songs = songs
//                musicPlayer.initializeData(with: viewModel)
                self.present(musicPlayer, animated: true, completion: nil)
//                print(viewModel.title,viewModel.artist,viewModel.imageName)
                break
                
            }
        }
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
