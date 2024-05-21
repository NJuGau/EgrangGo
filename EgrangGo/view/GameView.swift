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
}

struct GameView: View {
    @ObservedObject var gameModel = GameViewModel()
    
    let gameScene: GameScene
    
    
    init() {
        gameScene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        gameScene.gameOverProtocol = self
        gameScene.distanceProtocol = self
        gameScene.timeProtocol = self
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                
                SpriteView(scene: gameScene, options: [.allowsTransparency])
                
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
    }
    
    
}

extension GameView: GameOverProtocol {
    mutating func setGameOver(value: Bool) {
        playAudio(audioResourceId: ResourceHandler.sound.gameComplete, isLoop: false)
        gameModel.isGameOver = value
    }
}

extension GameView: DistanceProtocol {
    mutating func updateDistance(distance: Int) {
        gameModel.distance = (gameModel.isGameOver) ? gameModel.distance : distance
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
