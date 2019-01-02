//
//  ViewController.swift
//  Concentration
//
//  Created by Németh László Harri on 2018. 12. 14..
//  Copyright © 2018. Németh László Harri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // this is the reference to the model
    // () is the initializer
    // Classes get an init with no arguments by default
    // if all the arguments are initialized
    // The only property in Concentration is cards
    // lazy means it is not initialized until someone uses it.
    // but lazy cannot have property observers, like didSet
    // the number of pairs of cards in the game is tied to the UI, that's why it is private
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1 ) / 2
    }
    
    // property observer
    private(set) var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // ! means this property does not need initializer
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    // this would also be ok
    //var emojiChoices = ["👻", "🙊", "🦊", "🐶"]
    //var emojiChoices: Array<String> = ["👻", "🙊", "🦊", "🐶"]
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        // ! means "assume this optional is set, and grap the associated value
        // if it is not set, it will crash!
        //let cardNumber = cardButtons.firstIndex(of: sender)!
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            // here we need to update our view from our model
            updateViewFromModel()
        } else {
            print ("ERROR")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices: Array<String> = ["🐰", "🦇", "🐂", "🐈", "👻", "🙊", "🦊", "🐶", "🐮", "🐫", "🐳", "🦈", "🐠", "🦐", "🦂", "🦍", "🦏", "🐎", "🐬"]
    
    private var emoji = Dictionary<Int, String>()

    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil && emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }

/*
         if emoji[card.identifier] != nil {
             return emoji[card.identifier]!
         } else {
             return "?"
         }
*/
        
        // the above one can simply be written like this!
        return emoji[card.identifier] ?? "?"
    }
    /*

    @IBAction func touchMonkeyCard(_ sender: UIButton) {
        flipCard(withEmoji: "🙊", on: sender)
        flipCount += 1
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
 */
}
