//
//  QuizViewControllerMain.swift
//  TakeItEasy
//
//  Created by xcode on 6/7/22.
//

import UIKit

class QuizViewControllerMain: UIViewController{

    @IBAction func BeginSelected(_ sender: Any) {
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
          
                
    }
        func updateBorder(myButton: UIButton, borderWidth: CGFloat = 0) {
            myButton.layer.borderWidth = borderWidth
            myButton.layer.borderColor = UIColor.white.cgColor            }
                
    @IBAction func quiz1(_ sender: Any) {
       
    }
    @IBAction func quiz2(_ sender: Any) {
    }
    @IBAction func quiz3(_ sender: Any) {
    }
    @IBAction func quiz4(_ sender: Any) {
    }
    
    
    
    @IBOutlet weak var menuCollection: UICollectionView!
}






extension QuizViewControllerMain: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            guard let sell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell else {return MenuCollectionViewCell()}
        sell.q1.text = "Quiz1"
        sell.q2.text = "Quiz2"
        sell.q3.text = "Quiz3"
        sell.q4.text = "Quiz4"
           return sell
    }


    
}

