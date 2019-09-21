//
//  QuestionViewController.swift
//  Assignment
//
//  Created by Akash - iOS Dev on 21/09/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

enum AnswerType:String{
    case correct = "Correct Answer!"
    case incorrect = "Wrong Answer!"
    case none = ""
}

class QuestionViewController: UIViewController {
    @IBOutlet weak var timeLeftLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var remainingQuestionLbl: UILabel!
    @IBOutlet weak var answerTypeLbl: UILabel!
    
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    private var questionsData:[QuestionType] = []
    var quiz: EnumeratedIterator<IndexingIterator<Array<QuestionType>>>!
    var correctAnswer = UInt8()
    var correctAnswers = Int()
    var incorrectAnswers = Int()
    var answerButtons: [UIButton] {
        return [option1Button, option2Button, option3Button, option4Button]
    }
    let quizMaxTime:Int = 600   // quiz max time in seconds
    var quizTime:Int = 0
    var timer:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadData()
        if self.questionsData.count == 0{
              self.answerButtons.forEach { $0.isHidden = true }
            self.showNoQuestionAvailable()
        }else{
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.showQuestion()
            self.timeLeftLbl.text = CommonFunctions.shared.timeString(time: self.quizTime)
            self.setUpTimer()
        }
     
    }
    
    private func loadData(){
        self.questionsData = CommonFunctions.shared.readJSONFromFile()
        quiz = questionsData.enumerated().makeIterator()
    }
    
    private func showQuestion() {
        
        UIView.animate(withDuration: 0.75) {
            self.answerButtons.forEach { $0.alpha = 1 }

        }
        if let quizz = quiz.next() {
            let fullQuestion = quizz.element
            
            UIView.animate(withDuration: 0.1) {
                self.correctAnswer = fullQuestion.correct
                self.questionLbl.text = fullQuestion.question
                let answers = fullQuestion.answers
                for i in 0..<self.answerButtons.count {
                    self.answerButtons[i].setTitle(answers[i], for: .normal)
                }
                if let index = self.questionsData.index(of: fullQuestion) {
                    self.remainingQuestionLbl.text = "\(index + 1)/\(self.questionsData.count)"
                }
            }
        }
        else {
            endOfQuestionsAlert()
        }
    }
    
    private func setUpTimer(){
        self.quizTime = self.quizMaxTime;
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
    
    }
    
    
    @objc func updateTimeLeft(){
        if self.quizTime > 0{
            self.quizTime -= 1
            self.timeLeftLbl.text = CommonFunctions.shared.timeString(time: self.quizTime)
        }else{
            self.timer.invalidate()
            self.quizTime = self.quizMaxTime
            self.timeFinished()
        }
      
        
    }
    
   
    
    @IBAction func option1Action(_ sender: UIButton) {
        self.analyzeAnswer(answer: 0)
    }
    @IBAction func option2Action(_ sender: UIButton) {
         self.analyzeAnswer(answer: 1)
    }
    @IBAction func option3Action(_ sender: UIButton) {
         self.analyzeAnswer(answer: 2)
    }
    @IBAction func option4Action(_ sender: UIButton) {
         self.analyzeAnswer(answer: 3)
    }
    
    @IBAction func quitQuiz(_ sender: UIButton) {
            self.quitQuizz()
    }
    
    // func to check whether the answer selected by user is correct or incorrect and storing the value to userdefaults
    private func analyzeAnswer(answer: UInt8) {
        if answer == correctAnswer {
            correctAnswers += 1
        }
        else {
            incorrectAnswers += 1
        }
        
        UIView.animate(withDuration: 0.75) {
            self.answerButtons[Int(answer)].backgroundColor = (answer == self.correctAnswer) ? .darkGreen : .alternativeRed
        }
        
        UIView.animate(withDuration: 0.75) {
            self.answerButtons[Int(answer)].backgroundColor = .defaultBlue

        }
        
        showQuestion()
        
    }
    
    //func to show that time limit reached
    private func timeFinished(){
        let score = (correctAnswers * 20)
        let message = "You Score: " + "\(score) pts"
        self.showAlert(title: "Time Limit Reached", msg: message)
    }
    
    private func endOfQuestionsAlert() {
        let score = (correctAnswers * 20)
        let message = "Correct answers: " + "\(correctAnswers)" + "/" + "\(questionsData.count)"
        self.showAlert(title: "Score: " + "\(score) pts", msg: message)

    }
    
    
    private func showNoQuestionAvailable(){
        let message = "No Questions are available for the quiz at this moment. Please try again after sometime."
       self.showAlert(title: "", msg: message)
    }
    
  
    
    private func quitQuizz(){
        let title = "Quit Quiz"
        let message = "Are you sure you want to quit the Quiz??"
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.goBack()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertViewController.dismiss(animated: true, completion: nil)
        }
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true)
    }
    

}
