//
//  ViewController.swift
//  TakeItEasy
//  Created by AAron on 6/7/22.
//

import UIKit

class SpecificsViewController: UIViewController {
  
    let quizzes = ["Quiz 1 Easy difficulty", "Quiz 2 Super difficulty", "Quiz 3 Easy Difficulty", "Quiz 4 Super Difficulty"]
    @IBOutlet weak var sliderText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 5
        slider.minimumValue = 5
        slider.maximumValue = 25
        sliderText.text = String(Int(slider.value))
        _ = [quizzes]
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
    }
    @IBOutlet weak var QuizSearchView: UITableView!
}




extension SpecificsViewController: UITableViewDelegate, UITableViewDataSource{
 

        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return quizzes.count
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return 1
        }

   
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
          // cell.qsearchResult.text =
         //  quizzes[(indexPath.row)]
          return cell
           }
        }
        



