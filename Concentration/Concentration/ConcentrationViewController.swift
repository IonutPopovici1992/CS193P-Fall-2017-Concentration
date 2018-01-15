//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by John on 1/8/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    // ThemeData
    typealias ThemeData = (emoji: [String],
        backGroundColor: UIColor,
        cardBackColor: UIColor)
    
    // Themes dictionary
    private let themes: [String: ThemeData] = [
        "animals": (["🐶", "🙊", "🐧", "🦁", "🐆", "🐄", "🐿", "🐠", "🦆", "🦉"], #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
        "faces":  (["😀", "🤪", "😬", "😭", "😎", "😍", "🤠", "😇", "🤩", "🤢"], #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)),
        "fruits": (["🍏", "🥑", "🍇", "🍒", "🍑", "🥝", "🍐", "🍎", "🍉", "🍌"], #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
        "people": (["👩", "👮🏻‍♂️", "👩‍💻", "👨🏾‍🌾", "🧟‍♀️", "👩🏽‍🎨", "👩🏼‍🍳", "🧕🏼", "💆‍♂️", "🤷🏽‍♂️"], #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
        "sports": (["🏊🏽‍♀️", "🤽🏻‍♀️", "🤾🏾‍♂️", "⛹🏼‍♂️", "🏄🏻‍♀️", "🚴🏻‍♀️", "🚣🏿‍♀️", "⛷", "🏋🏿‍♀️", "🤸🏼‍♂️"], #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)),
        "transport": (["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"], #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
    ]
    
    private var newTheme: ThemeData {
        let randomIndex = themes.count.arc4random
        let key = Array(themes.keys)[randomIndex]
        return themes[key]!
    }
    
    private var theme: ThemeData! {
        didSet {
            view.backgroundColor = theme.backGroundColor
            cardButtons.forEach {
                $0.backgroundColor = theme.cardBackColor
                $0.setTitle("", for: UIControlState.normal)
            }
            flipCountLabel.textColor = theme.cardBackColor
            gameScoreLabel.textColor = theme.cardBackColor
        }
    }
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var newGameButton: UIButton! {
        didSet {
            newGameButton.titleLabel?.numberOfLines = 0
        }
    }
    
    @IBAction func onNewGame(_ sender: UIButton, forEvent event: UIEvent) {
        startNewGame()
    }
    
    // viewDidLoad()
    override func viewDidLoad() {
        startNewGame()
        
        newGameButton.layer.cornerRadius = 5
        newGameButton.layer.borderWidth = 1
        newGameButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func startNewGame() {
        theme = newTheme
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCountLabel.text = "Flips: \(game.flipCount)"
        gameScoreLabel.text = "Score: \(game.score)"
        emoji = [:]
        emojiChoices = theme.emoji
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipCountLabel.text = "Flips: \(game.flipCount)"
            gameScoreLabel.text = "Score: \(game.score)"
        } else {
            print("Chosen card was not in cardButtons.")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : theme.cardBackColor
            }
        }
    }
    
    private var emoji = [Int: String]()
    
    private lazy var emojiChoices: [String] = {
        return theme.emoji
    }()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        switch self {
            case 1...Int.max:
                return Int(arc4random_uniform(UInt32(self)))
            case -Int.max..<0:
                return Int(arc4random_uniform(UInt32(self)))
            default:
                return 0
        }
    }
}
