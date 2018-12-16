//
//  ViewController.swift
//  Concentration
//
//  Created by Németh László Harri on 2018. 12. 14..
//  Copyright © 2018. Németh László Harri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // property observer
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // ! means this property does not need initializer
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // this would also be ok
    //var emojiChoices = ["👻", "🙊", "🦊", "🐶"]
    var emojiChoices: Array<String> = ["👻", "🙊", "🦊", "🐶"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        // ! means "assume this optional is set, and grap the associated value
        // if it is not set, it will crash!
        //let cardNumber = cardButtons.firstIndex(of: sender)!
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print ("ERROR")
        }
    }
    
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
}
