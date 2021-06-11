//
//  Card.swift
//  Concentration
//
//  Created by Sergey Sokolkin on 10.06.21.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
