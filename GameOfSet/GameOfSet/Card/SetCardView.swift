//
//  SetCardView.swift
//  GameOfSet
//
//  Created by John on 2/13/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        setBasicLayoutForBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
        setBasicLayoutForBorder()
    }
    
    private func setBasicLayoutForBorder() {
        layer.borderWidth = LayoutMetricsForCardView.borderWidth
        layer.borderColor = LayoutMetricsForCardView.borderColor
        layer.cornerRadius = LayoutMetricsForCardView.cornerRadius
    }
    
    var cardIndex: Int = 0
    var card: CardForGameOfSet? {
        didSet {
            cardIndex = card != nil ? card!.hashValue : 0
            stateOfSetCardButton = .unselected
            setNeedsDisplay()
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setNeedsLayout()
    }
    
    private let objectSizeToLineWidthRatio: CGFloat = 10

    override func draw(_ rect: CGRect) {
        if let card = card {
            var color = UIColor()
            switch card.color {
                case .red: color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                case .green: color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                case .blue: color = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
            color.setFill()
            color.setStroke()
            
            let objectsForSet = ObjectsForSet(in: bounds, for: card.shape, numberOfObjects: card.number.rawValue)
            let path = objectsForSet.bezierPath
            path.lineWidth = objectsForSet.objectHeight * objectsForSet.fillFactor / objectSizeToLineWidthRatio
            path.stroke()
            switch card.fill {
                case .empty: break
                case .solid: path.fill()
                case .stripe:
                    path.addClip()
                    let stripesPath = objectsForSet.bezierPathForStripes
                    stripesPath.lineWidth = objectsForSet.objectHeight * objectsForSet.fillFactor/(objectSizeToLineWidthRatio * 2)
                    stripesPath.stroke()
            }
        }
    }
    
    enum StateOfSetCardButton {
        case unselected
        case selected
        case hinted
        case selectedAndMatched
    }
    
    var stateOfSetCardButton: StateOfSetCardButton = .unselected {
        didSet {
            switch stateOfSetCardButton {
                case .unselected:
                    layer.borderWidth = LayoutMetricsForCardView.borderWidth
                    layer.borderColor = LayoutMetricsForCardView.borderColor
                case .selected:
                    layer.borderWidth = LayoutMetricsForCardView.borderWidthIfSelected
                    layer.borderColor = LayoutMetricsForCardView.borderColorIfSelected
                case .hinted:
                    layer.borderWidth = LayoutMetricsForCardView.borderWidthIfHinted
                    layer.borderColor = LayoutMetricsForCardView.borderColorIfHinted
                case .selectedAndMatched:
                    layer.borderWidth = LayoutMetricsForCardView.borderWidthIfMatched
                    layer.borderColor = LayoutMetricsForCardView.borderColorIfMatched
            }
        }
    }

}
