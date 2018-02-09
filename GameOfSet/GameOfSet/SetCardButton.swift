//
//  SetCardButton.swift
//  GameOfSet
//
//  Created by John on 2/8/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class SetCardButton: UIButton {
    
    var cardIndex: Int = 0
    
    var card: CardForGameOfSet? {
        didSet {
            if let card = card {
                cardIndex = card.hashValue
                stateOfSetCardButton = .unselected
                let attrString = attributedString(for: card)
                setAttributedTitle(attrString, for: .normal)
            } else {
                cardIndex = 0
                setAttributedTitle(NSAttributedString(), for: .normal)
                stateOfSetCardButton = .unselected
            }
        }
    }
    
    private func setBorderLayout() {
        layer.borderWidth = LayoutMetricsForCardView.borderWidth
        layer.borderColor = LayoutMetricsForCardView.borderColor
        layer.cornerRadius = LayoutMetricsForCardView.cornerRadius
        titleLabel?.numberOfLines = 0
    }
    
    enum StateOfSetCardButton {
        case unselected
        case selected
        case selectedAndMatched
        case hinted
    }
    
    var stateOfSetCardButton: StateOfSetCardButton = .unselected {
        didSet {
            switch stateOfSetCardButton {
                case .unselected:
                    if oldValue == .selectedAndMatched {
                        setAttributedTitle(NSAttributedString(), for: .normal)
                    }
                    layer.borderWidth = LayoutMetricsForCardView.borderWidth
                    layer.borderColor = LayoutMetricsForCardView.borderColor
                case .selected:
                    layer.borderWidth = LayoutMetricsForCardView.borderWidthIfSelected
                    layer.borderColor = LayoutMetricsForCardView.borderColorIfSelected
                case .selectedAndMatched:
                    layer.borderWidth = LayoutMetricsForCardView.borderWidthIfMatched
                    layer.borderColor = LayoutMetricsForCardView.borderColorIfMatched
                case .hinted:
                    layer.borderWidth = LayoutMetricsForCardView.borderWidthIfHinted
                    layer.borderColor = LayoutMetricsForCardView.borderColorIfHinted
                }
        }
    }
    
    private func attributedString(for card: CardForGameOfSet) -> NSAttributedString {
        let shape: String = ModelToView.shapes[card.shape]!
        var returnString: String
        
        switch card.number {
            case .one:
                returnString = shape
            case .two:
                returnString = shape + "\n" + shape
            case .three:
                returnString = shape + "\n" + shape + "\n" + shape
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.80
        
        let attributes: [NSAttributedStringKey : Any] = [
            .strokeColor: ModelToView.colors[card.color]!,
            .strokeWidth: ModelToView.strokeWidth[card.fill]!,
            .foregroundColor: ModelToView.colors[card.color]!.withAlphaComponent(ModelToView.alpha[card.fill]!),
            .paragraphStyle: paragraphStyle
        ]
        
        return NSAttributedString(string: returnString, attributes: attributes)
    }
    
}
