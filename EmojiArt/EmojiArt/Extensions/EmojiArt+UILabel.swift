//
//  EmojiArt+UILabel.swift
//  EmojiArt
//
//  Created by John on 3/15/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func stretchToFit() {
        let oldCenter = center
        sizeToFit()
        center = oldCenter
    }

}
