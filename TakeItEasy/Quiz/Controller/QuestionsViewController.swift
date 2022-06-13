//
//  QuestionsViewController.swift
//  TakeItEasy
//
//  Created by xcode on 6/9/22.
//

import UIKit

class QuestionsViewController: UIViewController {
 
    @IBOutlet weak var answerCollection: UICollectionView!
    var viewModel = QuestionsViewModel()
    var questions:[Questions]?
    var answerSelected = false
    var isCorrectAnswer = false
    var rightAnswer = 0
    var  points = 0
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.QuestionData { [weak self] in
            self?.questions = self?.viewModel.questionData?.data?.questions
            DispatchQueue.main.async {
                self?.answerCollection.delegate = self
                self?.answerCollection.dataSource = self
                self?.answerCollection.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func onClickExit(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        
        if !answerSelected {
            // Show alert
            let alert = UIAlertController(title: "Select One Option", message: "Please select one option before moving to the next question.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        answerSelected = false
        if isCorrectAnswer {
            points += 5
            rightAnswer += 1
            print(points)
        }
        print(index)
        if index<(self.questions?.count ?? 0) - 1 {
            index += 1
            answerCollection.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)

        } else {
            // Move the user on the result controller
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController else {return}
            vc.result = points
            vc.rightA = rightAnswer
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
        
       

      
        
        
        
    }
    




    
    

extension QuestionsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCollectionViewCell", for: indexPath) as? QuizCollectionViewCell else {return QuizCollectionViewCell()}
        
        cell.setValues = questions?[indexPath.row]
        cell.selectedOption = { [weak self] isCorrect in
            self?.answerSelected = true
            self?.isCorrectAnswer = isCorrect
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

    

    

