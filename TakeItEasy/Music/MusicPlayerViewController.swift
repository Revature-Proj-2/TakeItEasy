//
//  MusicPlayerViewController.swift
//  TakeItEasy
//
//  Created by Conner Donnelly on 6/9/22.
//

import UIKit

class MusicPlayerViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    var vModel: MusicPlayerViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.initializeData(with: vModel!)
        // Do any additional setup after loading the view.
    }
    
    public func initializeData(with viewModel: MusicPlayerViewModel){
        albumImage.image = UIImage(named: viewModel.imageName)
        songTitle.text = viewModel.title
        artist.text = viewModel.artist
    }
    
    @IBAction func progressBarSlid(_ sender: Any) {
        
    }
    @IBAction func backTrackTap(_ sender: Any) {
        
    }
    @IBAction func playPauseTouch(_ sender: Any) {
        
    }
    @IBAction func stopTouch(_ sender: Any) {
        
    }
    @IBAction func forwardTrackTouch(_ sender: Any) {
        
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
