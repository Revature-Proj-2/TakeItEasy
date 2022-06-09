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
    var correct : String?
    var answerA : String?
    var answerB : String?
    var answerC : String?
    var answerD : String?
    var question : String?
    
    
}
