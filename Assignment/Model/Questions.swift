//
//  ReadData.swift
//  Assignment
//
//  Created by Akash - iOS Dev on 21/09/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

struct QuestionType:Codable, Equatable {
    
    static func ==(lhs: QuestionType, rhs: QuestionType) -> Bool {
        return lhs.question == rhs.question && lhs.answers == rhs.answers && lhs.correct == rhs.correct
    }
    let question: String
    let answers: [String]
    let correct: UInt8
}

