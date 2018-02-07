//
//  PlayingCardView+Settings.swift
//  PlayingCard
//
//  Created by John on 2/5/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

extension PlayingCardView {
    
    struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    var rankString: String {
        switch rank {
            case 1: return "A"
            case 2...10: return String(rank)
            case 11: return "J"
            case 12: return "Q"
            case 13: return "K"
            default: return "?"
        }
    }
    
}
