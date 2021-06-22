//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Sergey Sokolkin on 12.06.21.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    
    var description: String {
        return "\(rank)\(suit)"
    }
    
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CustomStringConvertible {
        
        case spades = "♠️"
        case hearts = "♥️"
        case clubs = "♣️"
        case diamonds = "♦️"
        
        static var all = [Suit.spades, .hearts, .diamonds, .clubs]
        
        var description: String {
            return self.rawValue
        }
    }
    
    enum Rank: CustomStringConvertible {
        
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks: [Rank] = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(.numeric(pips))
            }
            allRanks += [.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
        
        var description: String {
            switch self {
            case .ace: return "Ace"
            case .numeric(let pips): return "\(pips)"
            case .face(let kind) where kind == "J": return "Jack"
            case .face(let kind) where kind == "Q": return "Queen"
            case .face(let kind) where kind == "K": return "King"
            default: return ""
            }
        }
        
    }
    
}
