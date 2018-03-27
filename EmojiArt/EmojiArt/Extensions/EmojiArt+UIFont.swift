//
//  EmojiArt+UIFont.swift
//  EmojiArt
//
//  Created by John on 3/15/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    func scaled(by factor: CGFloat) -> UIFont {
        return withSize(pointSize * factor)
    }

    static var bodyScaledFont64Size = UIFontMetrics(forTextStyle: .body)
        .scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(64.0))
}
