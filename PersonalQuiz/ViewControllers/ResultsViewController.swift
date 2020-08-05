//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Александр Бехтер on 05.08.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var answers: [Answer]!
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var definitionResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true // скрыть кнопку возврата
        updateResult()
    }
    deinit {
        print("Results deinit")
    }
}

extension ResultsViewController {
    
    private func updateResult() { // метод расчета результата
        
        var frequencyOfAnimals:[AnimalType: Int] = [:]
        
        let animals = answers.map { $0.type }
        for animal in animals {
            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
        }
        
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequncyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequncyAnimal)
    }
    private func updateUI(with animal: AnimalType) {
        resultAnswerLabel.text = "Вы - \(animal.rawValue) !"
        definitionResultLabel.text = animal.definition
    }
}
