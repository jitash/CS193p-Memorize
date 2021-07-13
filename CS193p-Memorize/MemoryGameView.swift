//
//  ContentView.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel:MemoryGameViewModel
    
    var body: some View {
        ScrollView{
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3, content: {card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
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
                let shape = RoundedRectangle(cornerRadius: DrawingConstans.cornerRadius)
                if card.isFaceUp{
                    shape.fill().foregroundColor(.white)
                    shape.stroke(lineWidth: DrawingConstans.lineWidth)
                    
                            Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90)).padding(10).opacity(0.6)
                    
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched{
                    shape.opacity(0)
                } else{
                    shape.fill()
                }
            }
        })
        
    }
    private func font(in size:CGSize) -> Font{
        Font.system(size: min(size.width,size.height) * DrawingConstans.fontScale)
    }
    private struct DrawingConstans{
        static let cornerRadius:CGFloat = 10
        static let lineWidth:CGFloat = 3
        static let fontScale:CGFloat = 0.65
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game  = MemoryGameViewModel()
        MemoryGameView(viewModel: game)
    }
}
