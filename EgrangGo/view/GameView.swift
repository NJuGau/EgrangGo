//
//  GameView.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import SwiftUI
import SpriteKit
import AVFoundation


class GameViewModel: ObservableObject {
    @Published var isGameOver: Bool = false
    @Published var distance: Int = 0
    @Published var time: Int = 0
    @Published var gameScene: GameScene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
}

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
                            Image(uiImage: UIImage(imageLiteralResourceName: "TimeBox"))
                            Text("\(gameModel.time)")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        ZStack{
                            Image(uiImage: UIImage(imageLiteralResourceName: "DistanceBox"))
                            Text("Distance: \(gameModel.distance) M")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(32)
                    Spacer()
                }
                
                if gameModel.isGameOver {
                    ResultView(result: gameModel.distance, isGameOver: $gameModel.isGameOver)
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
