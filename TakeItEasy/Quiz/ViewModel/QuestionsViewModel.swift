//
//  QuestionsViewModel.swift
//  TakeItEasy
//
//  Created by xcode on 6/8/22.
//

import Foundation

class QuestionsViewModel {
   

 
 var questionData:DataModel?
 private let sURL = URL(string: "https://quiz-68112-default-rtdb.firebaseio.com/quiz.json")!

 func QuestionData(completion : @escaping () -> ()) {
     
     URLSession.shared.dataTask(with: sURL) { [weak self] (data, urlResponse, error) in
         if let data = data {
             
             let jsonDecoder = JSONDecoder()
             
             let final = try! jsonDecoder.decode(DataModel.self, from: data)
             self?.questionData = final
             print(final)
             completion()
         }
     }.resume()
 }
}

