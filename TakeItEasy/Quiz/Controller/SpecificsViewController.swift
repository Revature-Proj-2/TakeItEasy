//
//  ViewController.swift
//  TakeItEasy
//  Created by AAron on 6/7/22.
//

import UIKit

class SpecificsViewController: UIViewController {
    var searchActive = false
    var filtered:[String] = []
    let quizzes = ["Quiz 1 Easy difficulty", "Quiz 2 Super difficulty", "Quiz 3 Easy Difficulty", "Quiz 4 Super Difficulty"]
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var sliderText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        blurry.alpha = 1
        slider.value = 5
        slider.minimumValue = 5
        slider.maximumValue = 25
        sliderText.text = String(Int(slider.value))
    
       
               /* Setup delegates */
               QuizSearchView.delegate = self
               QuizSearchView.dataSource = self
               QuizSearchView.delegate = self

           
}
    @IBOutlet weak var difficultySwitcher: UISegmentedControl!
    
    @IBAction func searchIt(_ sender: Any) {
        blurry.alpha = 0
        return
        
    }
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
    @IBOutlet weak var blurry: UIVisualEffectView!
    @IBOutlet weak var QuizSearchView: UITableView!
}




extension SpecificsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
            } else {
            cell.textLabel?.text = quizzes[indexPath.row];
        }

            return cell;
    }
    
    
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quizzes.count
    }
    

 


       func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
           searchActive = true;
       }

       func searchBarTextDidEndEditing(searchBar: UISearchBar) {
           searchActive = false;
       }

       func searchBarCancelButtonClicked(searchBar: UISearchBar) {
           searchActive = false;
       }

       func searchBarSearchButtonClicked(searchBar: UISearchBar) {
           searchActive = false;
       }

       func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

           filtered = quizzes.filter({ (text) -> Bool in
               let tmp: NSString = text as NSString
               let range = tmp.range(of: searchText)
               return range.location != NSNotFound
           })
           if(filtered.count == 0){
               searchActive = false;
           } else {
               searchActive = true;
           }
           self.QuizSearchView.reloadData()
       }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }

       func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return 1
       }

}
