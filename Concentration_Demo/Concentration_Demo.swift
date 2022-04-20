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
    private(set) var cards = [Card]()
    private var Matches = 0
    private var Flips = 0
    private var Score = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp {
                    if foundIndex == nil{
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private let NumberOfPairs: Int?
    private var isGameOver = false
    
    func chooseCard(at index: Int) -> (WasFaceUp:Bool,isGameOver:Bool, Flips:Int, Score:Int) {
        assert(cards.indices.contains(index), "Concecntration_Demo.chooseCard(at: \(index)) : choosen inedx not in the cards")
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
            }
            else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        return (WasAlreadyFacedup, isGameOver, Flips, Score)
    }
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concecntration_Demo.init(\(numberOfPairsOfCards)) : must have at least one pair of cards")
        self.NumberOfPairs = numberOfPairsOfCards
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
