//
//  PlayingCardViewController.swift
//  PlayingCard
//
//  Created by John on 1/30/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class PlayingCardViewController: UIViewController {
    
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var card = deck.draw()
        
        while card != nil {
            print("\(card!)")
            card = deck.draw()
        }
    }

}
