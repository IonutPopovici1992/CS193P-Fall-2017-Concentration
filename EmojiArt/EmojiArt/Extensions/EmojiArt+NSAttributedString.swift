//
//  EmojiArt+NSAttributedString.swift
//  EmojiArt
//
//  Created by John on 3/15/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    func withFontScaled(by factor: CGFloat) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        mutable.setFont(mutable.font?.scaled(by: factor))
        return mutable
    }
    var font: UIFont? {
        get {
            return attribute(.font, at: 0, effectiveRange: nil) as? UIFont
        }
    }

}
