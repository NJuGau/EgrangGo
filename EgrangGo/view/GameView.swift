//
//  GameView.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import SwiftUI
import SpriteKit
import AVFoundation

struct GameView: View {
    @ObservedObject var gameModel = GameViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                
                SpriteView(scene: gameModel.gameScene, options: [.allowsTransparency])
                
                VStack{
                    HStack{
                        Spacer(minLength: CGFloat(Screen.width.rawValue) / 2 - 30)
                        ZStack{
                            Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.timeBox))
                            Text("\(gameModel.time)")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        ZStack{
                            Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.distanceBox))
                            Text("Distance: \(gameModel.distance) M")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(32)
                    Spacer()
                }
                
                if gameModel.isGameOver {
                    ResultView(result: gameModel.distance, isGameOver: $gameModel.isGameOver, isNewHighScore: gameModel.isNewHighScore, highScore: gameModel.highScoreHandler.getHighScore())
                }
            }
        }.navigationBarBackButtonHidden(true)
            .onAppear{
                gameModel.gameScene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                gameModel.gameScene.gameOverProtocol = self
                gameModel.gameScene.distanceProtocol = self
                gameModel.gameScene.timeProtocol = self
            }
    }
    
    
}

extension GameView: GameOverProtocol {
    mutating func setGameOver(value: Bool) {
        playAudio(audioResourceId: (gameModel.time <= 0) ? ResourceHandler.sound.timeUp : ResourceHandler.sound.fall, isLoop: false)
        gameModel.isGameOver = value
        
        //highscore setter
        let currentHighScore = gameModel.highScoreHandler.getHighScore()
        
        if currentHighScore < gameModel.distance {
            gameModel.highScoreHandler.setHighScore(newScore: gameModel.distance)
            gameModel.isNewHighScore = true
            playAudio(audioResourceId: ResourceHandler.sound.gameComplete, isLoop: false)
        } else {
            gameModel.isNewHighScore = false
        }
    }
}

extension GameView: DistanceProtocol {
    mutating func updateDistance(distance: Int) {
        if distance <= 0 {
            gameModel.distance = 0
        }else{
            gameModel.distance = (gameModel.isGameOver) ? gameModel.distance : distance
        }
    }
}

extension GameView: TimeProtocol {
    mutating func updateTime(time: Int) {
        gameModel.time = (gameModel.isGameOver) ? gameModel.time: time
    }
    
    
}

#Preview {
    GameView()
}
