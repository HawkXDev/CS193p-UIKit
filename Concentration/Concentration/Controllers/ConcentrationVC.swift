//
//  ConcentrationVC.swift
//  Concentration
//
//  Created by Sergey Sokolkin on 10.06.21.
//

import UIKit

class ConcentrationVC: VCLLoggingViewController {
    
    override var vclLoggingName: String {
        return "Game"
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        (visibleCardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.968627451, green: 0.8784313725, blue: 0.3568627451, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ? "Flips\n\(flipCount)" : "Flips: \(flipCount)",
            attributes: attributes
        )
        
        flipCountLabel.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🐭🐱🐶🐸🦁🐷🐮🐵🐨🦊🐯"
    
    private var emoji = [Card: String]()

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = visibleCardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices {
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.968627451, green: 0.8784313725, blue: 0.3568627451, alpha: 1)
                }
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
    }
    
}

// MARK: - ThemeSelectionDelegate

extension ConcentrationVC: ThemeSelectionDelegate {
    func themeSelected(_ newTheme: String) {
        theme = newTheme
    }
}

// MARK: - Int Exteinsion

extension Int {
    var random: Int {
        if self > 0 {
            return Int.random(in: 0..<self)
        } else if self < 0 {
            return -Int.random(in: 0..<abs(self))
        } else {
            return 0
        }
    }
}
