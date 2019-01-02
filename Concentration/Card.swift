//
//  Card.swift
//  Concentration
//
//  Created by Németh László Harri on 2018. 12. 17..
//  Copyright © 2018. Németh László Harri. All rights reserved.
//

import Foundation

// Card is a struct
// Difference from class:
//   - struct -- no inheritance
//   - value types   ... class is a reference type
//      - this means it gets copied!!!
//     Arrays, Ints, Strings, Dictionaries -- these are all structs! But swift implement these in a copy-on-write semantics. That's why it is fast.
// This card does not contain the emoji. This is the model, not the UI!
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // inits have usually the same internal name and external name
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
