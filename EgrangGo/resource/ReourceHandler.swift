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
    let backgroundSound = "Backsound.wav"
    var mudStep: String {
        let variation = Int.random(in: 1...2)
        return ("Mud\(variation).wav")
    }
    var groundStep: String {
        let variation = Int.random(in: 1...2)
        return ("Step\(variation).wav")
    }
    let gameComplete = "Result.wav"
    let stoneHit = "Stone.wav"
    let treePass = "Tree.wav"
    let waterSplash = "Water.wav"
    let wind = "Wind.wav"
}
