//
//  MemoryGameViewModel.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import SwiftUI


class MemoryGameViewModel:ObservableObject {
    typealias Card = MemoryGameModel<String>.Card
    
    private static let emojis=["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🦯","🦽","🦼","🛴","🚲","🛵","🏍","🛺","🚨","🚔"]
    
    private static func createMemoryGame() -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairsOfCards: 3){ pairIndex in
               emojis[pairIndex]
           }
    }
    
    @Published private var model: MemoryGameModel<String> = createMemoryGame()
    
    var cards: Array<Card>{
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card:Card){
        model.choose(card)
    }
     
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = MemoryGameViewModel.createMemoryGame()
    }
    
}
