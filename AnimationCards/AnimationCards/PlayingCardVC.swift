//
//  PlayingCardVC.swift
//  PlayingCard
//
//  Created by Sergey Sokolkin on 12.06.21.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import UIKit

class PlayingCardVC: UIViewController {
    
    private var deck = PlayingCardDeck()
    
    @IBOutlet private var cardViews: [PlayingCardView]!
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior(in: animator)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cards = [PlayingCard]()
        
        for _ in 1...((cardViews.count + 1) / 2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        
        for cardView in cardViews {
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            
            cardBehavior.addItem(cardView)
        }
    }
    
    private var faceUpCardViews: [PlayingCardView] {
        return cardViews.filter { $0.isFaceUp && !$0.isHidden }
    }
    
    private var faceUpCardViewsMatch: Bool {
        return faceUpCardViews.count == 2 &&
            faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
            faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let chosenCardView = recognizer.view as? PlayingCardView {
                UIView.transition(with: chosenCardView,
                                  duration: 0.6,
                                  options: [.transitionFlipFromLeft]) {
                    chosenCardView.isFaceUp = !chosenCardView.isFaceUp
                } completion: { finished in
                    if self.faceUpCardViewsMatch {
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6,
                                                                       delay: 0,
                                                                       options: []) {
                            self.faceUpCardViews.forEach {
                                $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                            }
                        } completion: { position in
                            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.75,
                                                                           delay: 0,
                                                                           options: []) {
                                self.faceUpCardViews.forEach {
                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                    $0.alpha = 0
                                }
                            } completion: { position in
                                self.faceUpCardViews.forEach {
                                    $0.isHidden = true
                                    $0.alpha = 1
                                    $0.transform = .identity
                                }
                            }
                        }

                    } else if self.faceUpCardViews.count == 2 {
                        self.faceUpCardViews.forEach { cardView in
                            UIView.transition(with: cardView,
                                              duration: 0.6,
                                              options: [.transitionFlipFromLeft]) {
                                cardView.isFaceUp = false
                            }
                        }
                    }
                }
            }
        default:
            break
        }
    }
    
}

extension CGFloat {
    var random: CGFloat {
        if self > 0 {
            return CGFloat.random(in: 0..<self)
        } else if self < 0 {
            return -CGFloat.random(in: 0..<abs(self))
        } else {
            return 0
        }
    }
}
