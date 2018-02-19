//
//  GameOfSet+CGFloat.swift
//  GameOfSet
//
//  Created by John on 2/13/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    var abs: CGFloat {
        return self < 0 ? -self : self
    }
}
