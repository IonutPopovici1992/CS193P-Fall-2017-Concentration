//
//  Concentration.swift
//  Concentration
//
//  Created by John on 1/8/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    var flipCount = 0
    
    static var matchPoints = 20
    static var wasFaceUpPenalty = 10
    static var maxTimePenalty = 10
    
    private var date = Date()
    private var currentDate: Date {
        return Date()
    }
    var timeInterval: Int {
        return Int(-date.timeIntervalSinceNow)
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    // increase the score
                    score += (Concentration.matchPoints - min(timeInterval, Concentration.maxTimePenalty))
                } else {
                    if cards[index].isSeen {
                        // decrease the score
                        score -= (Concentration.wasFaceUpPenalty + min(timeInterval, Concentration.maxTimePenalty))
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil // not one and only ...
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        flipCount += 1
        date = currentDate
    }
    
    init(numberOfPairsOfCards: Int) {
        var unShuffeldCards: [Card] = []
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unShuffeldCards += [card, card]
        }
        // TODO: Shuffle the cards
        while !unShuffeldCards.isEmpty {
            let randomIndex = unShuffeldCards.count.arc4random
            let card = unShuffeldCards.remove(at: randomIndex)
            cards.append(card)
        }
    }
    
}
