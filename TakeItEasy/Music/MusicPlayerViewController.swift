//
//  MusicPlayerViewController.swift
//  TakeItEasy
//
//  Created by Conner Donnelly on 6/9/22.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var backTrackButton: UIButton!
    @IBOutlet weak var forwardTrackButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var source: UILabel!
    
    var vModel: MusicPlayerViewModel?
    var fileURL:URL?
    var audioPlayer:AVPlayer?
    var playerItem:AVPlayerItem?
    var timer:Timer?
    var isPlaying:Bool = false
//    var songsPlayList = UserDefaults.standard
//    var songs:
    var album:Album?
    var index:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        songs = songsPlayList.object(forKey: "songData") as? [Song]
        
        //self.initializeData(with: vModel!)
        // Do any additional setup after loading the view.
    }
//    func firstLoad() async{
//        do{
//        try await Task.sleep(nanoseconds: 400)
//        self.initializeData(with: vModel!)
//        }catch{
//            print("Error Loading Media Player")
//        }
//    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        audioPlayer?.pause()
    }
    public func initializeData(with viewModel: MusicPlayerViewModel){
        if index == 0{
            //backTrackButton.backgroundColor = UIColor.systemGray
            backTrackButton.tintColor = .systemGray
            backTrackButton.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        }else{
            backTrackButton.tintColor = .systemYellow
            backTrackButton.setImage(UIImage(systemName: "backward.end"), for: .normal)
        }
        if index == (album!.tracks.data.count - 1){
            forwardTrackButton.tintColor = .systemGray
            forwardTrackButton.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        }else{
            forwardTrackButton.tintColor = .systemYellow
            forwardTrackButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
        }
        playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        stopButton.setImage(UIImage(systemName: "stop"), for: .normal)
        isPlaying = false
        progressSlider.value = 0
        let url = URL(string: viewModel.image)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            albumImage.image = UIImage(data: imageData)
        }
        songTitle.text = viewModel.title
        artist.text = viewModel.artist
        source.text = viewModel.album
        fileURL = URL(string: viewModel.url)
        print("*****************************************************")
        print(viewModel.url)
        do{
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
            playerItem = try AVPlayerItem(url:fileURL!)
            audioPlayer = AVPlayer(playerItem:playerItem)
            print("Found File")
        }catch{
            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
            print("Error Grabbing File")
        }
    }
    
    @IBAction func progressBarSlid(_ sender: Any) {
//        audioPlayer?.seek(to: CMTime.init(value: CMTimeValue(Float(progressSlider.value * Float((audioPlayer!.currentItem?.asset.duration)!))), timescale: 1000))
//        audioPlayer?.seek(to: CMTime(value: CMTimeValue(progressSlider.value * (audioPlayer!.currentItem?.asset.duration)!), timescale: 1000))
        var time = progressSlider.value * (30)
        audioPlayer!.seek(to:CMTimeMakeWithSeconds(Float64(time),preferredTimescale: 1000))
    }
    @IBAction func backTrackTap(_ sender: Any) {
        if index == 0 {
            print("This is the first track in the playlist")
        }else{
            index = index! - 1
            let model = album
    //        print(model.title)
            let viewModel = MusicPlayerViewModel(title: model!.tracks.data[index!].title, artist: model!.artist.name, image: model!.cover,album: model!.title, url: model!.tracks.data[index!].preview)
            self.initializeData(with: viewModel)
        }
    }
    @IBAction func forwardTrackTouch(_ sender: Any) {
        if index == (album!.tracks.data.count - 1) {
            print("This is the last track in the playlist")
        }else{
            index = index! + 1
            let model = album
    //        print(model.title)
            let viewModel = MusicPlayerViewModel(title: model!.tracks.data[index!].title, artist: model!.artist.name, image: model!.cover,album: model!.title, url: model!.tracks.data[index!].preview)
            self.initializeData(with: viewModel)
        }
    }
    @IBAction func playPauseTouch(_ sender: Any) {
        if isPlaying{
            isPlaying = false
            audioPlayer?.pause()
            timer?.invalidate()
            playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        }else{
            isPlaying = true
            audioPlayer?.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlayTime), userInfo: nil, repeats: true)
            playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            stopButton.setImage(UIImage(systemName: "stop"), for: .normal)
        }
        
        
    }
    @IBAction func stopTouch(_ sender: Any) {
        audioPlayer?.pause()
        timer?.invalidate()
        isPlaying = false
        stopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        audioPlayer?.seek(to:CMTime.zero)
        progressSlider.value = 0
    }
    
    @objc func updatePlayTime(){
        progressSlider.value = Float(audioPlayer!.currentTime().seconds/30.0)
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
