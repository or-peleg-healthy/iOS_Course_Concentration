//
//  ViewController.swift
//  Concentration_Demo
//
//  Created by Or Peleg on 13/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration_Demo(numberOfPairsOfCards: numberOfPairsOfCards)
    // lazy var cant use didSet
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    } // Computed variable is a read only so no-need get
    
    @IBOutlet private(set) weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var ScoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func NewGame(_ sender: UIButton) {
        game = Concentration_Demo(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = Theme.getRandomTheme()
        ScoreLabel.text = ""
        flipCountLabel.text = "Flips :0"
        for button in cardButtons{
            button.isEnabled = true
        }
        updateViewFromModel()
    }
    
    // MARK: Handle Card Touch Behavior
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            let (WasFaceUp,isGameOver, flips, result) = game.chooseCard(at: cardNumber)
            if !WasFaceUp{
                flipCountLabel.text = "Flips :\(flips)"
            }
            if isGameOver{
                ScoreLabel.text = "Score :\(result)"
            }
            updateViewFromModel()
        }else{
            print("chosen card is not in card buttons")
        }
    }
    
    private var emojiChoices = Theme.getRandomTheme()
    
    private var emoji_dict = [Int:String]()
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                if card.isMatched{
                    button.isEnabled = false
                }
            }
        }
        
        func emoji(for card: Card) -> String {
            if emoji_dict[card.identifier] == nil {
                if emojiChoices.count > 0 {
                    emoji_dict[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
                }
            }
            return emoji_dict[card.identifier] ?? "?"
        }
    }
}

extension Int {
    var arc4random: Int{
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}
