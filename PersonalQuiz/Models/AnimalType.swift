//
//  AnimalType.swift
//  PersonalQuiz
//
//  Created by Александр Бехтер on 05.08.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

enum AnimalType: Character{
    case dog = "🐶"
    case cat = "🐱"
    case turtle = "🐢"
    case rabbit = "🐰"
    
    var definition: String {
        switch self {
        case .dog:
            return "You dog"
        case .cat:
            return "You Cat"
        case .turtle:
            return "You turtle"
        case .rabbit:
            return "You rebbit"
        }
    }
}
