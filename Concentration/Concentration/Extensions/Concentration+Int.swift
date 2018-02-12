//
//  Concentration+Int.swift
//  Concentration
//
//  Created by John on 1/17/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

// MARK: Int extension
extension Int {
    var arc4random: Int {
        switch self {
            case 1...Int.max:
                return Int(arc4random_uniform(UInt32(self)))
            case -Int.max..<0:
                return Int(arc4random_uniform(UInt32(self)))
            default:
                return 0
        }
    }
}
