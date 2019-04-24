//
//  Card.swift
//  Concentration
//
//  Created by Maxwell Chukwuemeka on 26/12/2018.
//  Copyright © 2018 Maxwell. All rights reserved.
//

import Foundation

struct Card {

    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() { 
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
