//
//  Constant.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 20/05/24.
//

import Foundation


enum Screen: Int {
    case width = 1024
    case height = 768
}

func generateTerrain() -> Int {
    return Screen.width.rawValue * 5
}
