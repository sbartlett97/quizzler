//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
    var currentQuestion: Question?
    var questionNum: Int = 0
    var score: Int = 0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        nextQuestion()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            checkAnswer(answer: true)
        }else{
            checkAnswer(answer: false)
        }
        nextQuestion()
    }
    
    
    func updateUI() {
        progressLabel.text = "\(questionNum)/13"
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNum)
    }
    

    func nextQuestion() {
        updateUI()
        if questionNum < 13{
            questionLabel.text = allQuestions.list[questionNum].questionText
            currentQuestion = allQuestions.list[questionNum]
        }else{
            let alert = UIAlertController(title: "Quizz Finished!", message: "Would you like to try again?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in
                self.startOver()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer(answer: Bool) {
        if answer == currentQuestion?.answer{
            ProgressHUD.showSuccess("Correct!")
            score += 10
        }else{
            ProgressHUD.showError("Wrong!")
        }
        questionNum += 1
    }
    
    
    func startOver() {
        questionNum = 0
        score = 0
        nextQuestion()
        updateUI()
    }
    

    
}
