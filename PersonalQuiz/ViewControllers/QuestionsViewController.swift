//
//  QuestionsViewController.swift
//  PersonalQuiz
//
//  Created by Александр Бехтер on 05.08.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
//MARK: - IBOutlets
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    private let questions = Question.getQuestion()
    private var questionIndex = 0
    private var answersChoosen: [Answer] = []
    
    private var answers: [Answer] {
       questions[questionIndex].answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI() // скрываем элементы
    }
    
    //MARK: = IBActions
    
    @IBAction func singleAnswersButtonPressed(_ sender: UIButton) {
        guard let currentIndexButton = singleButtons.firstIndex(of: sender) else { return }
        
        let currentAnswer = answers[currentIndexButton]
        answersChoosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwith, answer) in zip(multipleSwitches, answers) {
            if multipleSwith.isOn {
                answersChoosen.append(answer)
            }
        }
        nextQuestion()
    }
    @IBAction func rangedAnswerButtonPressed() {
        let index = lroundf(rangedSlider.value * Float(answers.count - 1))
        let currentAnswer = answers[index]
        answersChoosen.append(currentAnswer)
        nextQuestion()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    deinit {
        print("QuestionVC deinit")
    }
}

//MARK: - Private Methods
extension QuestionsViewController {
    private func updateUI() {
    
        for stackView in [singleStackView, multipleStackView, rangedStackView] { // скрытие стэков
            stackView?.isHidden = true
        }
        
        // получение вопросов
        let currentQuestion = questions[questionIndex]
        
        // установить текущий вопрос в label
        questionLabel.text = currentQuestion.text
        
        // работа с progressView Calculate progress
        
        let totalProgress = Float(questionIndex) / Float(questions.count)  // задаем прогресс для ProgressView исходя из колличества вопросов
        // Set progress for progressView
        
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // Установить номер вопроса для navigation bar
        
        title = "Вопрос №\(questionIndex + 1) из \(questions.count)"
        
        //
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    // вывод ответов в label
    private func showCurrentAnswers(for type: ResponseType) {
        // в зависимости от того какая категория будет выбрана , нужно отобрадать или скрывать тот или иной стэкВью
        
        switch type {
        case .single: showSingleStackView(with: answers)
        case .multiple: showMultipleStackView(with: answers)
        case .ranged: showRangedStackView(with: answers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) { // передаем ответы в кнопки
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
            
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
}

//MARK: - Navigation

extension QuestionsViewController {
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "resultSegue" else { return }
        let resultsVC = segue.destination as! ResultsViewController
        resultsVC.answers = answersChoosen
    }
}
