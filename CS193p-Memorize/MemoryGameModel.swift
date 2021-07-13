//
//  MemoryGame.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import Foundation
struct MemoryGameModel<CardContent> where CardContent:Equatable {
    private(set) var cards:Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard:Int?
    
    mutating func choose(_ card:Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[potentialMatchIndex].content == cards[chosenIndex].content{
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }else{
                for index in cards.indices{
                    cards[index].isFaceUp=false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
        
        
    }
    
    init(numberOfPairsOfCards:Int,createCardContent:(Int) ->CardContent) {
        cards = Array<Card>()
        //todo add numberOfPairsOfCards x 2  cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content:CardContent = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex*2,content: content))
            cards.append(Card(id: pairIndex*2+1,content: content))
        }
        
    }
    
    struct Card:Identifiable{
        var id:Int
        
        var isFaceUp = false
        var isMatched = false
        var content:CardContent
    }
}
