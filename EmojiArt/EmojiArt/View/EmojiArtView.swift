//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by John on 3/14/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {
    
    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }

}
