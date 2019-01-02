//
//  Concentration.swift
//  Concentration
//
//  Created by Németh László Harri on 2018. 12. 17..
//  Copyright © 2018. Németh László Harri. All rights reserved.
//

import Foundation

// this is the model
// struct is a value type, it is constantly copied everywhere
struct Concentration {
    
    // here () is the initializer
    // array is a value type and Card is a value type
    // this means it cannot be modified
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if indexOfOneAndOnlyFaceUpCard != nil {
                if indexOfOneAndOnlyFaceUpCard != index {
                    let matchIndex = indexOfOneAndOnlyFaceUpCard!
                    // check if cards match
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                    cards[index].isFaceUp = true
                }
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // initializers can be private as well, but in this case it should not be private
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        // CountableRange is a Sequence
        // special syntax
        // 1...numberOfPairsOfCards -- [1 -- numberOfPairsOfCards]
        // 0..<numberOfPairsOfCards -- [0 -- numberOfPairsOfCards-1]
        // _ means I DONT CARE! DONT GIVE IT A NAME!
        for _ in 0..<numberOfPairsOfCards {
            // structs get a free initializer as well
            let card = Card()
            cards.append(card)
            cards.append(card) // this creates a copy of card!! also assignment creates a copy!!
            // or
            //   cards += [card, card]
            // this is the same
        }
    }
}
