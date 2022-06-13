//
//  QuestionsModel.swift
//  TakeItEasy
//
//  Created by xcode on 6/8/22.
//

import Foundation

struct DataModel: Codable{
    var data : QuestionsModel?
}

struct QuestionsModel: Codable {
    var questions: [Questions]?
    
}

    
    


struct Questions: Codable {
    var id: Int?
    var correct_answer: String?
    var option_1: String?
    var option_2: String?
    var option_3: String?
    var option_4: String?
    var question: String?


}
