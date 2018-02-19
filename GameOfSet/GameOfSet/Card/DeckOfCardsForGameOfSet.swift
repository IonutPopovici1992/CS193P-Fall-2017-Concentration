//
//  DeckOfCardsForGameOfSet.swift
//  GameOfSet
//
//  Created by John on 2/8/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

struct DeckOfCardsForGameOfSet: CustomStringConvertible {
    
    private(set) var cards = [CardForGameOfSet]()
    
    mutating func draw(n: validDraws = .three) -> [CardForGameOfSet]? {
        if cards.count < n.rawValue {
            return nil
        }
        
        var returnArray = [CardForGameOfSet]()
        for _ in 1...n.rawValue {
            returnArray.append(cards.remove(at: cards.count.arc4random))
        }
        
        return returnArray
    }
    
    var count: Int {
        return cards.count
    }
    
    enum validDraws: Int {
        case three = 3
        case twelve = 12
    }
    
    init() {
        let rangeOfThree = 1...3
        for number in rangeOfThree {
            for color in rangeOfThree {
                for shape in rangeOfThree {
                    for fill in rangeOfThree {
                        let card = CardForGameOfSet(with: number, color, shape, fill)
                        cards.append(card)
                    }
                }
            }
        }
    }
    
    var description: String {
        var returnString = ""
        for card in cards {
            returnString += "\(card)\n"
        }
        return returnString
    }
    
}
