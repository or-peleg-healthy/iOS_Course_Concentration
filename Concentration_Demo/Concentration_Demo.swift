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
    var Matches = 0
    var Flips = 0
    var Score = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    let NumberOfPairs: Int?
    var isGameOver = false
    
    func chooseCard(at index: Int) -> (WasFaceUp:Bool,isGameOver:Bool, Flips:Int, Score:Int) {
        Flips += 1
        var WasAlreadyFacedup = false
        if cards[index].isFaceUp == true{
            WasAlreadyFacedup = true
        }
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    Matches += 1
                    Score += 2
                    if Matches == NumberOfPairs{
                        isGameOver = true
                    }
                }
                else
                {
                    if cards[matchIndex].wasFlippedBefore{
                        Score -= 1
                    }
                    if cards[index].wasFlippedBefore{
                        Score -= 1
                    }
                    cards[index].wasFlippedBefore = true
                    cards[matchIndex].wasFlippedBefore = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        return (WasAlreadyFacedup, isGameOver, Flips, Score)
    }
    init(numberOfPairsOfCards: Int){
        self.NumberOfPairs = numberOfPairsOfCards
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
