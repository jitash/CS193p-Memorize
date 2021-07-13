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
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
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
    let card: MemoryGameModel<String>.Card
    
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched{
                shape.opacity(0)
            } else{
                shape.fill()
            }
        }
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game  = MemoryGameViewModel()
        MemoryGameView(viewModel: game)
    }
}
