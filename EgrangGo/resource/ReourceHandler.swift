//
//  ReourceHandler.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 18/05/24.
//

import Foundation

enum ResourceHandler {
    static let sound = SoundResourceHandler()
}


struct SoundResourceHandler {
    let backgroundSound = "Backsound"
    var mudStep: String {
        let variation = Int.random(in: 1...2)
        return ("Mud\(variation)")
    }
    var groundStep: String {
        let variation = Int.random(in: 1...2)
        return ("Step\(variation)")
    }
    let gameComplete = "Result"
    let stoneHit = "Stone"
    let treePass = "Tree"
    let waterSplash = "Water"
    let wind = "Wind"
    let fall = "Fall"
    let countdown = "Countdown"
    let timeUp = "TimeUp"
}
