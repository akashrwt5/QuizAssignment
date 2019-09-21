//
//  CommonFunctions.swift
//  Assignment
//
//  Created by Akash - iOS Dev on 21/09/19.
//  Copyright © 2019 Developer. All rights reserved.
//
//
import Foundation

//singleton class
class CommonFunctions {
    
    static let shared = CommonFunctions()
    
    private init() {
    }

    // func to read the data from file
    func readJSONFromFile() -> [QuestionType]
    {
        var questionsData:[QuestionType]
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            questionsData = try JSONDecoder().decode([QuestionType].self, from: data)
            return questionsData
        } catch {
//            print("Error initializing quiz content")
        }
        
        return []
    }
    
    
    //func display time format in hours,minutes & seconds
    func timeString(time:Int) -> String {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
  
}
