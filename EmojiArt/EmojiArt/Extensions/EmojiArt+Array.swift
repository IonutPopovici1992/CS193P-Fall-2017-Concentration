//
//  EmojiArt+Array.swift
//  EmojiArt
//
//  Created by John on 3/15/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: Equatable {
    
    var uniquified: [Element] {
        var elements = [Element]()
        forEach {
            if !elements.contains($0) {
                elements.append($0)
            }
        }
        return elements
    }

}
