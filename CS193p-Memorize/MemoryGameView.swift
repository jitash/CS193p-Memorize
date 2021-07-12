//
//  ContentView.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import SwiftUI

struct MemoryGameView: View {
    
    let emojis=["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🦯","🦽","🦼","🛴","🚲","🛵","🏍","🛺","🚨","🚔"]
    @State var emojiCount = 4
    var body: some View {
        VStack{
            ScrollView{
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))], content: {
                    ForEach(emojis[0..<emojis.count],id:\.self){emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3,contentMode: .fit)
                    }
                })
            }
            Spacer()
            HStack{
                remove
                Spacer()
                add
            }
            
        }.padding(.all)
    }
    var remove:some View{
        Button(action: {
            if emojiCount > 0 {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    var add:some View{
        Button(action: {
            if emojiCount < emojis.count{
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
}

struct CardView:View {
    var content:String
    @State var isFaceUp = false
    
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            }else{
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView()
    }
}
