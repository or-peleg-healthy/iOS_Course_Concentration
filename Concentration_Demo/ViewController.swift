//
//  ViewController.swift
//  Concentration_Demo
//
//  Created by Or Peleg on 13/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration_Demo(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    // lazy var cant use didSet
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
            
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card is not in card buttons")
        }
        
    }
    
    var emojiChoices = ["👻", "🧠", "👽", "🫁", "💩", "🫀", "👣", "🫦", "🦷", "👃🏻"]
    
    var emoji_dict = [Int:String]()
    
    func updateViewFromModel(){
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
            }
        }
        
        func emoji(for card: Card) -> String {
            if emoji_dict[card.identifier] == nil {
                if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji_dict[card.identifier] = emojiChoices.remove(at: randomIndex)
                }
            }
            return emoji_dict[card.identifier] ?? "?"
        }
    }
}
