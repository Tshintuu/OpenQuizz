//
//  Game.swift
//  OpenQuizz
//
//  Created by Developer on 02/11/2021.
//

import Foundation

class Game {
    var score = 0
    
    private var questions = [Question]()
    private var currentIndex = 0
    
    var state: State = .ongoing
    var questionsLeft: Int {
        return questions.count - currentIndex
    }
    
    var currentQuestion: Question {
        return questions[currentIndex]
    }
    
    enum State {
        case ongoing, over
    }
    
    func answerCurrentQuestion(with answer: Bool) {
        if answer == currentQuestion.isCorrect {
            score += 1
        }
        goToNextQuestion()
    }
    
    func refresh() {
        score = 0
        state = .over
        currentIndex = 0
        
        QuestionManager.shared.get {(questions) in
            self.questions = questions
            self.state = .ongoing
            
            let name = Notification.Name(rawValue: "QuestionsLoaded")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        }
    }
    
    func goToNextQuestion() {
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        } else {
            finishGame()
        }
    }
    
    private func finishGame() {
        state = .over
    }
}
