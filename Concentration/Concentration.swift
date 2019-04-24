//
//  Concentration.swift
//  Concentration
//
//  Created by Maxwell Chukwuemeka on 26/12/2018.
//  Copyright © 2018 Maxwell. All rights reserved.
//

import Foundation

struct  Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneOnlyFacedUpCard : Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneOnlyFacedUpCard, matchIndex != index{
                // check if card match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{
                // either no cards or 2 cards are faced up
                indexOfOneOnlyFacedUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards : Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of card")
        // Or u say 1...numberOfPairsOfCards
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card] //or
            //cards.append(card)
            //cards.append(card)
            cards.shuffle()
        }
        // TODO : Shuffle the cards
    }
    
}
