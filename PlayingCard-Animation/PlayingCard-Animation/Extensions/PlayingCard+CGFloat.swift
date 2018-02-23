//
//  PlayingCard+CGFloat.swift
//  PlayingCard-Animation
//
//  Created by John on 2/23/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    var arc4randomCGFloat: CGFloat {
        return self * (CGFloat(arc4random_uniform(UInt32.max)) / CGFloat(UInt32.max))
    }
}
