//
//  MemoryGameViewModel.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import SwiftUI



class MemoryGameViewModel {
    
    static let emojis=["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🦯","🦽","🦼","🛴","🚲","🛵","🏍","🛺","🚨","🚔"]
    
    static func createMemoryGame() -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairsOfCards: 4){ pairIndex in
               emojis[pairIndex]
           }
    }
    
    private var model: MemoryGameModel<String> = createMemoryGame()
    
    
    
    var cards: Array<MemoryGameModel<String>.Card>{
        return model.cards
    }
}
