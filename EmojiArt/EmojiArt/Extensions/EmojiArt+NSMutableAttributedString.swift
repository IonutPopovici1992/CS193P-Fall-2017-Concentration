//
//  EmojiArt+NSMutableAttributedString.swift
//  EmojiArt
//
//  Created by John on 3/15/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func setFont(_ newValue: UIFont?) {
        if newValue != nil {
            addAttributes([.font: newValue!], range: NSMakeRange(0, length))
        }
    }

}
