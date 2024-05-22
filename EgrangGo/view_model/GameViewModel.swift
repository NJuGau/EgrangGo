//
//  GameViewModel.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 22/05/24.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var isGameOver: Bool = false
    @Published var distance: Int = 0
    @Published var time: Int = 0
    @Published var gameScene: GameScene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
}
