//
//  ContentView.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var game:MemoryGameViewModel
    
    var body: some View {
        ScrollView{
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: {card in
                if card.isMatched && !card.isFaceUp{
                    Rectangle().opacity(0)
                }else{
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }).foregroundColor(.red)
        }.padding(.all)
    }
    
}

struct CardView:View {
    let card: MemoryGameViewModel.Card
    
    var body: some View{
        GeometryReader(content: { geometry in
            ZStack{
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90))
                    .padding(8)
                    .opacity(0.6)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstans.fontSize))
                    .scaleEffect(scale(thatFits:geometry.size))
            }
            .modifier(Cardify(isFaceUp: card.isFaceUp))
            
        })
        
    }
    private func scale(thatFits size:CGSize) -> CGFloat{
        min(size.width,size.height)/(DrawingConstans.fontSize / DrawingConstans.fontScale)
    }
    
    private struct DrawingConstans{
        static let fontScale:CGFloat = 0.65
        static let fontSize:CGFloat = 32
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game  = MemoryGameViewModel()
        MemoryGameView(game: game)
    }
}
