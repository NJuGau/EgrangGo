//
//  Protocol.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import Foundation
protocol GameOverProtocol {
    mutating func setGameOver(value: Bool) -> Void
}

protocol DistanceProtocol {
    mutating func updateDistance(distance: Int) -> Void
}

protocol TimeProtocol {
    mutating func updateTime(time: Int) -> Void
}
