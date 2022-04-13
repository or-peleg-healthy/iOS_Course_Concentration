//
//  Concentration_Demo.swift
//  Concentration_Demo
//
//  Created by Or Peleg on 13/04/2022.
//

import Foundation
import UIKit

class Concentration_Demo
{
    var cards = [Card]()
    
    func chooseCard(at index: Int){
        if cards[index].isFaceUp{
            cards[index].isFaceUp = false
        }else
        {
            cards[index].isFaceUp = true
        }
    }
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
