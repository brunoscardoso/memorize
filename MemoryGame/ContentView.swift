//
//  ContentView.swift
//  MemoryGame
//
//  Created by Bruno Cardoso on 05/01/24.
//

import SwiftUI

struct ContentView: View {
    var emojisList: [String] = ["🐶", "🐱", "🐭", "🦊", "🐻", "🐼", "🐶", "🐱", "🐭", "🦊", "🐻", "🐼"]
    var themeOne: [String] = ["🚗", "🚕", "🚑", "🚙", "🏎️", "🚌", "🚎", "🚓", "🚗", "🚕", "🚑", "🚙", "🏎️", "🚌", "🚎", "🚓"]
    
    @State var emojiCount: Int = 12
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            buttons
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<emojiCount, id: \.self) { index in
                CardView(emoji: emojisList[index])
            }
        }.foregroundColor(.orange)
    }
    
    func handleCards(by offset: Int, symbol: String) -> some View {
        Button(action: {
            emojiCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(emojiCount + offset < 1 || emojiCount + offset > emojisList.count)
    }
    
    var cardAdder: some View {
        handleCards(by: +1, symbol: "rectangle.stack.badge.plus")
    }
    
    var cardRemover: some View {
        handleCards(by: -1, symbol: "rectangle.stack.badge.minus")
    }
    
    var buttons: some View {
        HStack {
            cardAdder
            Spacer()
            cardRemover
        }.font(.largeTitle)
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = false
    let emoji: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white).strokeBorder(lineWidth: 2)
                Text(emoji)
            }
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }.aspectRatio(6/3, contentMode: .fit).font(.largeTitle)
    }
}


#Preview {
    ContentView()
}

