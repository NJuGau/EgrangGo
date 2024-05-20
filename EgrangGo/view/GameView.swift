//
//  GameView.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    var gameScene : GameScene
    init() {
        gameScene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    var body: some View {
        ZStack{
            
            SpriteView(scene: GameScene())
            Text("test")
        }
    }
}

#Preview {
    GameView()
}
