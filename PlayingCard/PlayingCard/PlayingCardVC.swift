//
//  PlayingCardVC.swift
//  PlayingCard
//
//  Created by Sergey Sokolkin on 12.06.21.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import UIKit

class PlayingCardVC: UIViewController {
    
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print(card)
            }
        }
    }

}
