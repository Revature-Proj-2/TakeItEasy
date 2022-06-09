//
//  QuizViewControllerMain.swift
//  TakeItEasy
//
//  Created by xcode on 6/7/22.
//

import UIKit

class QuizViewControllerMain: UIViewController {

        var viewModel = QuestionsViewModel()
        var quesitions:DataModel?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            viewModel.QuestionData { [weak self] in
                self?.quesitions = self?.viewModel.questionData
                
                DispatchQueue.main.async {
                  //  self?.tableView.reloadData()
                }
                
            }
        }


    }


