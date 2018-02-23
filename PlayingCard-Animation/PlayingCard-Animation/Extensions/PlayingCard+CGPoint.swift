//
//  PlayingCard+CGPoint.swift
//  PlayingCard-Animation
//
//  Created by John on 2/20/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
    
}
