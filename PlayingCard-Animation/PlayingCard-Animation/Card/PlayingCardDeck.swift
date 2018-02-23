//
//  PlayingCardDeck.swift
//  PlayingCard-Animation
//
//  Created by John on 2/19/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    
    private(set) var cards = [PlayingCard]()
    
    mutating func draw() -> PlayingCard? {
        if cards.isEmpty { return nil }
        return cards.remove(at: cards.count.arc4random)
    }
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
}
