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
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards:Int,createCardContent:(Int) ->CardContent) {
        cards = []
        //todo add numberOfPairsOfCards x 2  cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content:CardContent = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex*2,content: content))
            cards.append(Card(id: pairIndex*2+1,content: content))
        }
        cards.shuffle()
    }
    
    struct Card:Identifiable{
        let id:Int
        
        var isFaceUp = false{
            didSet{
                if isFaceUp{
                    startUsingBonusTime()
                }else{
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false{
            didSet{
                stopUsingBonusTime()
            }
        }
        let content:CardContent
        
        // MARK: -Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during the card is face up
        
        // can ben zero which means "no bonus avaliable" for this card
        var bonusTimeLimit:TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime:TimeInterval{
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }else{
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate:Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime:TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaning:TimeInterval{
            max(0,bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaing:Double{
            (bonusTimeLimit > 0 && bonusTimeRemaning > 0) ? bonusTimeRemaning/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus:Bool{
            isMatched && bonusTimeRemaning > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime:Bool{
            isFaceUp && !isMatched && bonusTimeRemaning > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil{
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
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
