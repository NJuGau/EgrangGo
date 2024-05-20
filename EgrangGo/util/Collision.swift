//
//  Collision.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 18/05/24.
//

import Foundation

enum CollisionCategory: UInt32 {
    case ground = 1
    case playerBody = 2
    case playerLeg = 4
    case rock = 8
    case cat = 16
    case water = 32
}
