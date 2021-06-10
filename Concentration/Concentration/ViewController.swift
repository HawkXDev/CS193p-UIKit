//
//  ViewController.swift
//  Concentration
//
//  Created by Sergey Sokolkin on 10.06.21.
//

import UIKit

class ViewController: UIViewController {
    
    internal var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = ["🐭", "🐱", "🐭", "🐱"]

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.8784313725, blue: 0.3568627451, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        }
    }
    
}

