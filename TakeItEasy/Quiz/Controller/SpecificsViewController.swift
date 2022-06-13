//
//  ViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/7/22.
//

import UIKit

class SpecificsViewController: UIViewController {

    
    @IBOutlet weak var sliderText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 5
        slider.minimumValue = 5
        slider.maximumValue = 25
        sliderText.text = String(Int(slider.value))
}
    @IBOutlet weak var difficultySwitcher: UISegmentedControl!
    
    @IBAction func BeginSelected(_ sender: Any) {
        
    }
    let step: Float = 1
  
    @IBAction func switchDiffculty(_ sender: UISegmentedControl) {
        
    }
    @IBOutlet weak var slider: UISlider!
    @IBAction func sliderValueChanged(sender: UISlider) {
        sliderText.text = String(Int(sender.value))
}
}
