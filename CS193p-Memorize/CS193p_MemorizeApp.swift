//
//  CS193p_MemorizeApp.swift
//  CS193p-Memorize
//
//  Created by jitash on 2021/7/12.
//

import SwiftUI

@main
struct CS193p_MemorizeApp: App {
    private let game = MemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            MemoryGameView(game: game)
        }
    }
}
