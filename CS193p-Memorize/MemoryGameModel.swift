//
//  MemoryGame.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import Foundation
struct MemoryGameModel<CardContent> {
    private(set) var cards:Array<Card>
    
    func choose(_ card:Card) {
        
        
        
    }
    init(numberOfPairsOfCards:Int,createCardContent:(Int) ->CardContent) {
        cards = Array<Card>()
        //todo add numberOfPairsOfCards x 2  cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content:CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
            
        }
        
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content:CardContent
    }
}
