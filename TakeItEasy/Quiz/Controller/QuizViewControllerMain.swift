//
//  QuizViewControllerMain.swift
//  TakeItEasy
//
//  Created by AAron on 6/7/22.
//

import UIKit
import SwiftUI
import CoreData
class QuizViewControllerMain: UIViewController{
    var quizlet : Quizlet?
    @IBOutlet weak var blurr: UIVisualEffectView!
    @State private var alpha = 0
    

    override func viewDidLoad() {
            super.viewDidLoad()
      
        
      
        blurr.alpha = 0
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        totalPoints.text = "\(quizlet?.totalQuiz ?? "0")"
    }
    override func viewWillAppear(_ animated: Bool) {
     
            totalPoints.text = quizlet?.totalQuiz
        
    }
    
    @IBOutlet weak var userNames: UILabel!
    
    @IBOutlet weak var totalPoints: UILabel!
  
    @IBAction func quizSelect(_ sender: Any) {
        
        blurr.alpha = 1
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

