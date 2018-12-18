//
//  Concentration.swift
//  Concentration
//
//  Created by Németh László Harri on 2018. 12. 17..
//  Copyright © 2018. Németh László Harri. All rights reserved.
//

import Foundation

// this is the model
class Concentration {
    
    // here () is the initializer
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
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
    
    func chooseCard(at index: Int) {
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
                    //it is computed!! indexOfOneAndOnlyFaceUpCard = nil
                }
            } else {
//                // either 2 cards on no cards face up
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
        /*
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }*/
    }
    
    init(numberOfPairsOfCards: Int) {
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
        // TODO SHUFFLE THE CARDS!!!
        //
        //╭━━━━━━╋╋╋╋

    }
}
