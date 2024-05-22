//
//  Tree.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 22/05/24.
//

import Foundation
import SpriteKit

class Tree: SKSpriteNode {
    init(x: CGFloat) {
        let txt = SKTexture(imageNamed: ResourceHandler.image.tree)
        
        super.init(texture: txt, color: .white, size: txt.size())
        position.y = CGFloat(-Screen.height.rawValue/2 + 100)
        position.x = x
        zPosition = 0
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
}
