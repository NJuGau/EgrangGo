//
//  Player.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 18/05/24.
//

import SpriteKit

class PlayerBody: SKSpriteNode {
    init(){
        let txt = SKTexture(imageNamed: "Player_Body")
        
        super.init(texture: txt, color: .white, size: txt.size())
        
        name = "playerBody"
        physicsBody = SKPhysicsBody(texture: texture!, size: texture!.size())
        physicsBody?.categoryBitMask = CollisionCategory.playerBody.rawValue
        physicsBody?.collisionBitMask = CollisionCategory.ground.rawValue | CollisionCategory.rock.rawValue | CollisionCategory.cat.rawValue
        physicsBody?.contactTestBitMask = CollisionCategory.ground.rawValue | CollisionCategory.rock.rawValue | CollisionCategory.cat.rawValue
        physicsBody?.isDynamic = true
        
        //positioning
        position.y = 105
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
}

class PlayerLeg: SKSpriteNode {
    init(){
        let txt = SKTexture(imageNamed: "Player_Leg")
        
        super.init(texture: txt, color: .white, size: txt.size())
        physicsBody = SKPhysicsBody(texture: texture!, size: texture!.size())
        physicsBody?.categoryBitMask = CollisionCategory.playerLeg.rawValue
        physicsBody?.collisionBitMask = CollisionCategory.ground.rawValue | CollisionCategory.rock.rawValue | CollisionCategory.cat.rawValue
        physicsBody?.contactTestBitMask = CollisionCategory.ground.rawValue | CollisionCategory.rock.rawValue | CollisionCategory.cat.rawValue
//        physicsBody?.mass = 9999999
        position.y = -195
        position.x = 50
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
}
