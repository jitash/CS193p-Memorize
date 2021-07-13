//
//  Cardify.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/13.
//

import SwiftUI

struct Cardify:ViewModifier {
    var isFaceUp:Bool
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstans.cornerRadius)
            
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstans.lineWidth)

            } else{
                shape.fill()
            }
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstans{
        static let cornerRadius:CGFloat = 10
        static let lineWidth:CGFloat = 3
    }
}

extension View{
    func cardify(isFaceUp:Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
