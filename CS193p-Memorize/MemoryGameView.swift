//
//  ContentView.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var game:MemoryGameViewModel
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment:.bottom){
            VStack{
                gameBody
                HStack{
                    restart
                    Spacer()
                    shuffle
                }
            }
            deckBody
        }.padding()
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card:MemoryGameViewModel.Card){
        dealt.insert(card.id)
    }
    private func isUndealt(_ card:MemoryGameViewModel.Card)-> Bool{
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card:MemoryGameViewModel.Card) -> Animation{
        var dealy = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}){
            dealy = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(dealy)
    }
    
    private func zIndex(of card :MemoryGameViewModel.Card) -> Double{
        let z = -Double(game.cards.firstIndex(where: {$0.id == card.id})  ?? 0)
        return z
    }
    
    var gameBody:some View{
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: {card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            }else{
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                    .zIndex(zIndex(of:card))
                    .onTapGesture {
                        withAnimation{
                            game.choose(card)
                        }
                    }
            }
        })
        .foregroundColor(CardConstants.color)
    }
    
    var deckBody:some View{
        ZStack{
            ForEach(game.cards.filter(isUndealt)) {card in
                CardView(card: card)    
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .scale))
            }
            .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight, alignment: .bottom)
            .foregroundColor(CardConstants.color)
            .onTapGesture {
                // deal cards
                for card in game.cards{
                    withAnimation(dealAnimation(for: card)){
                        deal(card)
                    }
                }
            }
        }
    }
    
    var shuffle:some View{
        Button("Shuffle"){
            withAnimation{
                game.shuffle()
            }
        }
    }
    
    var restart:some View{
        Button("Restart"){
            withAnimation{
                dealt = []
                game.restart()
            }
        }
    }
    
    private struct CardConstants{
        static let color = Color.red
        static let aspectRatio:CGFloat = 2/3
        static let dealDuration:Double = 0.5
        static let totalDealDuration:Double = 2
        static let undealHeight:CGFloat = 90
        static let undealWidth = undealHeight * aspectRatio
    }
}

struct CardView:View {
    let card: MemoryGameViewModel.Card
    @State private var animatedBonusRemaining:Double = 0
    
    var body: some View{
        GeometryReader(content: { geometry in
            ZStack{
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear{
                                animatedBonusRemaining = card.bonusRemaing
                                withAnimation(.linear(duration:card.bonusTimeRemaning)){
                                    animatedBonusRemaining = 0
                                }
                            }
                    }else{
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - card.bonusRemaing) * 360 - 90))
                    }
                }
                    .padding(8)
                    .opacity(0.6)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstans.fontSize))
                    .scaleEffect(scale(thatFits:geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            
        })
        
    }
    private func scale(thatFits size:CGSize) -> CGFloat{
        min(size.width,size.height)/(DrawingConstans.fontSize / DrawingConstans.fontScale)
    }
    
    private struct DrawingConstans{
        static let fontScale:CGFloat = 0.65
        static let fontSize:CGFloat = 28
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game  = MemoryGameViewModel()
        MemoryGameView(game: game)
    }
}
