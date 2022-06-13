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
    var vModel: MusicPlayerViewModel?
    var fileURL:URL?
    var audioPlayer:AVAudioPlayer?
    var timer:Timer?
    var isPlaying:Bool = false
    var songsPlayList = UserDefaults.standard
    var songs:[Song]?
    var index:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        songs = songsPlayList.object(forKey: "songData") as? [Song]
        self.initializeData(with: vModel!)
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        audioPlayer?.stop()
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
        if index == (songs!.count - 1){
            forwardTrackButton.tintColor = .systemGray
            forwardTrackButton.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        }else{
            forwardTrackButton.tintColor = .systemYellow
            forwardTrackButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
        }
        playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        isPlaying = false
        progressSlider.value = 0
        albumImage.image = UIImage(named: viewModel.imageName)
        songTitle.text = viewModel.title
        artist.text = viewModel.artist
        fileURL = viewModel.url
        do{
            audioPlayer = try AVAudioPlayer(contentsOf:fileURL!)
        }catch{
            print{"Error Grabbing File"}
        }
    }
    
    @IBAction func progressBarSlid(_ sender: Any) {
        audioPlayer?.currentTime = Double(progressSlider.value * Float(audioPlayer!.duration))
    }
    @IBAction func backTrackTap(_ sender: Any) {
        if index == 0 {
            print("This is the first track in the playlist")
        }else{
            index = index! - 1
            let model = songs![index!]
            let viewModel = MusicPlayerViewModel(title: model.title, artist: model.artist, imageName: model.albumImageName, url:model.url)
            self.initializeData(with: viewModel)
        }
    }
    @IBAction func forwardTrackTouch(_ sender: Any) {
        if index == (songs!.count - 1) {
            print("This is the last track in the playlist")
        }else{
            index = index! + 1
            let model = songs![index!]
            let viewModel = MusicPlayerViewModel(title: model.title, artist: model.artist, imageName: model.albumImageName,url:model.url)
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
        audioPlayer?.stop()
        timer?.invalidate()
        isPlaying = false
        stopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        audioPlayer?.currentTime = 0
        progressSlider.value = 0
    }
    
    @objc func updatePlayTime(){
        progressSlider.value = Float(audioPlayer!.currentTime)/Float(audioPlayer!.duration)
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
