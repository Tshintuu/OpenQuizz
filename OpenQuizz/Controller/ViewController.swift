//
//  ViewController.swift
//  OpenQuizz
//
//  Created by Developer on 03/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionsLeftLabel: UILabel!
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var difficultyView: DifficultyView!
    @IBOutlet weak var timeProgressView: UIProgressView!
    
    var game = Game()
    var resetTimer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name(rawValue: "QuestionsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(questionsLoaded), name: name, object: nil)
        
        startNewGame()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuestionView(_:)))
        questionView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func questionsLoaded() {
        activityIndicator.isHidden = true
        newGameButton.isHidden = false
        difficultyView.isHidden = false
        questionsLeftLabel.isHidden = false
        timeProgressView.isHidden = false
        
        questionView.title = game.currentQuestion.title
        questionsLeftLabel.text = "Questions left : \(game.questionsLeft)"
        questionView.category = game.currentQuestion.category
        showDifficultyLevel(level: game.currentQuestion.difficulty)
        questionTimer()
    }
    
    @IBAction func didTapNewGameButton() {
        startNewGame()
    }
    
    private func startNewGame() {
        activityIndicator.isHidden = false
        newGameButton.isHidden = true
        difficultyView.isHidden = true
        questionsLeftLabel.isHidden = true
        
        questionView.title = "Loading..."
        questionView.style = .standard
        
        scoreLabel.text = "0 / 10"
        
        game.refresh()
    }
    
    @objc func dragQuestionView(_ sender: UIPanGestureRecognizer) {
        if game.state == .ongoing {
            switch sender.state {
            case .began, .changed:
                transformQuestionViewWith(gesture: sender)
            case .cancelled, .ended:
                answerQuestion()
            default:
                break
            }
        }
    }
    
    private func transformQuestionViewWith(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: questionView)
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        let screenWidth = UIScreen.main.bounds.width
        let translationPercent = translation.x / (screenWidth / 2)
        let rotationAngle = (CGFloat.pi / 6) * translationPercent
        
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        
        let transform = translationTransform.concatenating(rotationTransform)
        
        questionView.transform = transform
        
        if translation.x > 0 {
            questionView.style = .correct
        } else {
            questionView.style = .incorrect
        }
    }
    
    private func answerQuestion(isTimeOver: Bool = false) {
        resetTimer = true
        
        if !isTimeOver {
            switch questionView.style {
            case .correct:
                game.answerCurrentQuestion(with: true)
            case .incorrect:
                game.answerCurrentQuestion(with: false)
            case .standard:
                break
            }
        } else {
            game.goToNextQuestion()
        }
        
        
        scoreLabel.text = "\(game.score) / 10"
        questionsLeftLabel.text = "Questions left : \(game.questionsLeft)"
        
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform: CGAffineTransform
        if questionView.style == .correct {
            translationTransform = CGAffineTransform(translationX: screenWidth, y: 0)
        } else {
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.questionView.transform = translationTransform
        }) { (success) in
            if success {
                self.showQuestionView()
            }
        }
    }
    
    private func showQuestionView() {
        questionView.transform = .identity
        questionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        questionView.style = .standard
        timeProgressView.progress = 1.0
        
        switch game.state {
        case .ongoing:
            questionView.title = game.currentQuestion.title
            questionView.category = game.currentQuestion.category
            showDifficultyLevel(level: game.currentQuestion.difficulty)
            questionTimer()
        case .over:
            questionView.title = "Game Over"
            questionView.category = ""
            difficultyView.isHidden = true
            questionsLeftLabel.isHidden = true
            timeProgressView.isHidden = true
        }
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.questionView.transform = .identity
        }, completion: nil)

    }
    
    private func showDifficultyLevel(level: Question.Difficulty) {
        switch level {
        case .easy:
            difficultyView.style = .easy
        case .medium:
            difficultyView.style = .medium
        case .hard:
            difficultyView.style = .hard
        case .unknown:
            difficultyView.style = .unknown
        }
    }
    
    private func questionTimer() {
        var timerCount: Float = 0.0
        resetTimer = false
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            timerCount += 0.02
            self.timeProgressView.progress = (10.0 - timerCount) / 10.0
            
            if self.resetTimer {
                timer.invalidate()
            } else if timerCount > 10 {
                self.answerQuestion(isTimeOver: true)
                timer.invalidate()
            }
            
        }
    }
}
