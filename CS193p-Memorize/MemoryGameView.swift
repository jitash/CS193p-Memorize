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
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                    ForEach(viewModel.cards){card in
                        CardView(card: card)
                            .aspectRatio(2/3,contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
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
        static let cornerRadius:CGFloat = 20
        static let lineWidth:CGFloat = 3
        static let fontScale:CGFloat = 0.8
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game  = MemoryGameViewModel()
        MemoryGameView(viewModel: game)
    }
}
