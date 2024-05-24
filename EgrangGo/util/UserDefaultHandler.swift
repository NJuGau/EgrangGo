//
//  UserDefaultHandler.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 24/05/24.
//

import Foundation

struct HighScoreHandler {
    let userDefault = UserDefaults.standard
    let highScoreKey = "highScore"
    
    func setHighScore(newScore: Int) {
        userDefault.set(newScore, forKey: highScoreKey)
    }
    
    func getHighScore() -> Int {
        return userDefault.integer(forKey: highScoreKey)
    }
}
