//
//  ReourceHandler.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 18/05/24.
//

import Foundation

enum ResourceHandler {
    static let sound = SoundResourceHandler()
    static let image = ImageResourceHandler()
    static let video = VideoResourceHandler()
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

struct ImageResourceHandler {
    let gameBackground = "Background"
    let logo = "Logo"
    let gameTitle = "Title"
    let gameOverText = "GameOver"
    let helpText = "Tutorial"
    
    let playerBody = "Player_Body"
    let playerLeftLeg = "LeftLeg"
    let playerRightLeg = "RightLeg"
    
    let cat = "Cat"
    let mud = "Mud"
    let rock = "Rock"
    let leaf = "Leaf"
    let tree = "Tree"
    let water = "Water"
    let wind = "Wind"
    
    let homeButton = "Home"
    let pauseButton = "Pause"
    let startButton = "Start"
    let exitButton = "ExitButton"
    let helpButton = "HelpButton"
    
    let joystickBack = "Joystick_Back"
    let joystickFront = "Joystick_Front"
    
    let timeBox = "TimeBox"
    let distanceBox = "DistanceBox"
    let resultBox = "ResultBox"
    let helpBox = "HelpBackground"
    
    let SoundwaveHigh = "Soundwave_High"
    let SoundwaveMedium = "Soundwave_Medium"
    let SoundwaveLow = "Soundwave_Low"
}

struct VideoResourceHandler {
    let walkingTutorial = "TutorialWalking"
}
