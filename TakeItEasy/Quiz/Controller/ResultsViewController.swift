//
//  ResultsViewController.swift
//  TakeItEasy
//
//  Created by xcode on 6/9/22.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBAction func tryAgain(_ sender: Any) {
    }
    @IBAction func backHome(_ sender: Any) {
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var rightAnswer: UILabel!
    
    var result = 0
    var rightA = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "\(result)"
        rightAnswer.text = "\(rightA)"
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
