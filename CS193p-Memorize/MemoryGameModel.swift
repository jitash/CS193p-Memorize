//
//  MemoryGame.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import Foundation
struct MemoryGameModel<CardContent> where CardContent:Equatable {
    
    private(set) var cards:Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard:Int?{
        get{cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly}
        set{cards.indices.forEach{cards[$0].isFaceUp = ($0 == newValue)}}
    }
    
    mutating func choose(_ card:Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[potentialMatchIndex].content == cards[chosenIndex].content{
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            }else{
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        
    }
    
    init(numberOfPairsOfCards:Int,createCardContent:(Int) ->CardContent) {
        cards = []
        //todo add numberOfPairsOfCards x 2  cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content:CardContent = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex*2,content: content))
            cards.append(Card(id: pairIndex*2+1,content: content))
        }
        
    }
    
    struct Card:Identifiable{
        let id:Int
        
        var isFaceUp = false
        var isMatched = false
        let content:CardContent
    }
    
    
}

extension Array{
    var oneAndOnly:Element?{
        if count == 1{
            return first
        }else{
            return nil
        }
    }
    
}
