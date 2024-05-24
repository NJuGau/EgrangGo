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
                    ResultView(result: gameModel.distance, isGameOver: $gameModel.isGameOver, highScore: gameModel.highScoreHandler.getHighScore())
                }
            }
        }.navigationBarBackButtonHidden(true)
            .onAppear{
                gameModel.gameScene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                gameModel.gameScene.gameOverProtocol = self
                gameModel.gameScene.distanceProtocol = self
                gameModel.gameScene.timeProtocol = self
            }
            .ignoresSafeArea(.all)
            .statusBarHidden(true)
    }
    
    
}

extension GameView: GameOverProtocol {
    func setGameOver(value: Bool) {
        DispatchQueue.main.async {
            playAudio(audioResourceId: (gameModel.time <= 0) ? ResourceHandler.sound.timeUp : ResourceHandler.sound.fall, isLoop: false)
            
            //highscore setter
            let currentHighScore = gameModel.highScoreHandler.getHighScore()
            
            if currentHighScore < gameModel.distance {
                gameModel.highScoreHandler.setHighScore(newScore: gameModel.distance)
            }
            
            //result enabler
            gameModel.isGameOver = value
        }
    }
}

extension GameView: DistanceProtocol {
    func updateDistance(distance: Int) {
        DispatchQueue.main.async {
            if distance <= 0 {
                gameModel.distance = 0
            }else{
                gameModel.distance = (gameModel.isGameOver) ? gameModel.distance : distance
            }
        }
    }
}

extension GameView: TimeProtocol {
     func updateTime(time: Int) {
         DispatchQueue.main.async {
             gameModel.time = (gameModel.isGameOver) ? gameModel.time: time
         }
    }
    
    
}

#Preview {
    GameView()
}
