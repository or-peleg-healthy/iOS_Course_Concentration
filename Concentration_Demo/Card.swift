//
//  Card.swift
//  Concentration_Demo
//
//  Created by Or Peleg on 13/04/2022.
//

import Foundation

struct Card: Hashable
{
    // doesn't require the displayed emoji.
    // the emoji only involves the view.
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.identifier == rhs.identifier 
    }

    var isFaceUp = false
    var isMatched = false
    var wasFlippedBefore = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
