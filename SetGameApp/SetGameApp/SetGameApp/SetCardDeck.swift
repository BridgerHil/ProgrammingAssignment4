//
//  SetCardDeck.swift
//  SetGameApp
//
//  Created by Bridger Hildreth on 3/6/22.
//

import Foundation

struct SetCardDeck {
    private var deck = Array<SetCard>()
    
    mutating func dealCard() -> SetCard? {
        if(self.isEmpty()) {
            return nil
        } else {
            return self.deck.remove(at: 0)
        }
    }
    
    func count() -> Int {
        self.deck.count
    }
    
    func isEmpty() -> Bool {
        (deck.count == 0) ? true: false
    }
    
    init() {
        var id = 1
        for color in SetCard.Colors.all {
            for shape in SetCard.Shapes.all {
                for shade in SetCard.Shades.all {
                    for count in 1...3 {
                        self.deck += [SetCard(shape: shape, shade: shade, color: color, count: count, id: id)]
                        id += 1
                    }
                }
            }
        }
        deck.shuffle()
    }
    
    mutating func remove() -> SetCard {
        return deck.remove(at: 0)
    }
    
    mutating func shuffleDeck() {
        deck.shuffle()
    }
}
