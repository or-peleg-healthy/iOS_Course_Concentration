//
//  Card.swift
//  Concentration_Demo
//
//  Created by Or Peleg on 13/04/2022.
//

import Foundation

struct Card
{
    // doesn't require the displayed emoji.
    // the emoji only involves the view.
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
