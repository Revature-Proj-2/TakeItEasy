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
    var album:Album?
    var index:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
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
        print(viewModel.url)
        do{
            playerItem = try AVPlayerItem(url:fileURL!)
            audioPlayer = AVPlayer(playerItem:playerItem)
            print("Found File")
        }catch{
            print("Error Grabbing File")
        }
    }
    
    @IBAction func progressBarSlid(_ sender: Any) {
        var time = progressSlider.value * (30)
        audioPlayer!.seek(to:CMTimeMakeWithSeconds(Float64(time),preferredTimescale: 1000))
    }
    @IBAction func backTrackTap(_ sender: Any) {
        if index == 0 {
            print("This is the first track in the playlist")
        }else{
            index = index! - 1
            let model = album
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
}
