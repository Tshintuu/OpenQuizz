//
//  Question.swift
//  OpenQuizz
//
//  Created by Developer on 02/11/2021.
//

import Foundation


struct Question {
    var title = ""
    var isCorrect = false
    var category = ""
    var difficulty: Difficulty = .medium
    
    enum Difficulty {
        case easy, medium, hard, unknown
    }
    
}
