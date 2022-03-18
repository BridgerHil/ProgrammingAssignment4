//
//  ViewModel.swift
//  SetGameApp
//
//  Created by Bridger Hildreth on 3/6/22.
//

import SwiftUI

class ViewModel: ObservableObject {

    @Published private(set) var deckModel = SetCardDeck()
    @Published private(set) var model = SetGame()
    
    func choose(card: SetCard) {
        model.selectCard(card)
    }
    
    func addThreeCards() {
        model.add3Cards()
    }
    
    func newGame() {
        model.newGameButton()
    }
    
    func cardsInDeckCounter() {
        print(deckModel.count())
    }
    
    func deckCounter() -> Int {
        return model.deckCounter()
    }
    
    func shuffleDeck() {
        shuffleDeck()
    }
}
