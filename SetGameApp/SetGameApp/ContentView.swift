//
//  ContentView.swift
//  SetGameApp
//
//  Created by Bridger Hildreth on 3/6/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()

    
    var body: some View {
        VStack {
            gameBody
                .padding(.vertical)

            HStack {
                discardBody
                Spacer()
                deckBody
            }
            .padding(.horizontal)
    
            newGame
         
        }
    }
    
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.model.cards, aspectRatio: 3/2) { setCard in
            SetCardView(setCard)
                .onTapGesture {
                    viewModel.choose(card: setCard)
                }
        }
    }
    
    var showDeckCount: some View {
        return Text("Deck: \(viewModel.deckCounter()) cards left")
    }
    
    var newGame: some View {
        Button {
            viewModel.newGame()
        } label: {
            Text("New Game")
                .foregroundColor(.red)
        }
    }
    
//    var plusThree: some View {
//        Button {
//            viewModel.addThreeCards()
//        } label: {
//            Text("Add 3 Cards")
//                .foregroundColor(.red)
//        }
//    }
    
    var discardBody: some View {
        VStack {
            DiscardPileView()
            Text("\n")
        }
    }
    
    
    var deckBody: some View {
        Button {
            viewModel.addThreeCards()
        } label: {
            VStack {
                DeckPileView()
                Text("Add 3 Cards\n\(viewModel.deckCounter()) Cards Left")
                
            }
            
            
        }
    }
}

struct DiscardPileView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        if viewModel.model.discardDeck.isEmpty {
            GeometryReader { geometry in
                VStack {
                    let roundedRectangle = RoundedRectangle(cornerRadius: 10)
                    roundedRectangle.fill()
                        .foregroundColor(Color.white)
                    roundedRectangle.stroke(lineWidth: 3.0)
                        .foregroundColor(Color.black)
                }
            }
        } else {
            let discardDeckLength = viewModel.model.discardDeck.count - 1
            SetCardView(viewModel.model.discardDeck[discardDeckLength])
        }
    }
}

struct DeckPileView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let roundedRectangle = RoundedRectangle(cornerRadius: 10)
                roundedRectangle.fill()
                    .foregroundColor(Color.white)
                roundedRectangle.stroke(lineWidth: 3.0)
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct SetCardView: View {
    
    private let setCard: SetCard
    private let lineColor: Color
    
    init(_ setCard: SetCard) {
        self.setCard = setCard
        if setCard.isSelected {
            lineColor = Color.black
        } else if setCard.isMatched {
            lineColor = Color.green
        } else if setCard.isMisMatched {
            lineColor = Color.red
        } else {
            lineColor = Color.gray
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let roundedRectangle = RoundedRectangle(cornerRadius: 10)
                roundedRectangle.fill()
                    .foregroundColor(Color.white)
                roundedRectangle.stroke(lineWidth: 3.0)
                    .foregroundColor(lineColor)
                if setCard.shade == .outlined {
                    getPath(for: setCard, in: geometry.frame(in: .local))
                        .stroke(colorForPath(for: setCard))
                } else if setCard.shade == .filled {
                    getPath(for: setCard, in: geometry.frame(in: .local))
                        .fill(colorForFill(for: setCard))
                } else if setCard.shade == .striped {
                    getPath(for: setCard, in: geometry.frame(in: .local))
                        .stroke(colorForPath(for: setCard))
                        .clipShape(getPath(for: setCard, in: geometry.frame(in: .local)))
                }
            }
         
            .rotationEffect(Angle.degrees(setCard.isMatched ? 360 : 0))
            .animation(Animation.linear(duration: 3))
            .rotationEffect(Angle.degrees(setCard.isMisMatched ? 45 : 0))
            .animation(Animation.linear(duration: 1))
        }
        .padding()
    }
    
    private func colorForFill(for setCard: SetCard) -> Color {
        switch setCard.shade {
        case .outlined:
            return .clear
        case .striped:
            return .clear
        case .filled:
            return colorForPath(for: setCard)
        }
    }
    
    private func getPath(for setCard: SetCard, in rect: CGRect) -> Path {
        var path: Path
        switch setCard.shape {
        case SetCard.Shapes.diamond:
            path = Diamond().path(in: rect)
        case SetCard.Shapes.oval:
            path = Oval().path(in: rect)
        case SetCard.Shapes.squiggle:
            path = Squiggle().path(in: rect)
        }
        
        path = replicatePath(path, for: setCard, in: rect)
        
        if(setCard.shade == .striped) {
            path.addPath(getStripedPath(in: rect))
        }
        
        return path
    }
    
    private func getStripedPath(in rect: CGRect) -> Path {
        var stripedPath = Path()
        
        let dy: CGFloat = rect.height/10.0
        var start = CGPoint(x: 0.0, y: dy)
        var end = CGPoint(x: rect.width, y: dy)
        
        while start.y < rect.height {
            stripedPath.move(to: start)
            stripedPath.addLine(to: end)
            start.y += dy
            end.y += dy
        }
        
        return stripedPath
    }
    
    private func colorForPath(for setCard: SetCard) -> Color {
        switch setCard.color {
        case SetCard.Colors.green:
            return .green
        case SetCard.Colors.blue:
            return .blue
        case SetCard.Colors.red:
            return .red
        }
    }
    
    private func replicatePath(_ path: Path, for setCard: SetCard, in rect: CGRect) -> Path {
        var leftTwoPathTranslation: CGPoint {
            return CGPoint(x: rect.width * -0.15, y: 0.0)
        }
        var rightTwoPathTranslation: CGPoint {
            return CGPoint(x: rect.width * 0.15, y: 0.0)
        }
        var leftThreePathTranslation: CGPoint {
            return CGPoint(x: rect.width * -0.25, y: 0.0)
        }
        var rightThreePathTranslation: CGPoint {
            return CGPoint(x: rect.width * 0.25, y: 0.0)
        }
        
        var replicatedPath = Path()
        
        if(setCard.count == 1) {
            replicatedPath = path
        } else if(setCard.count == 2) {
            let leftTransform = CGAffineTransform(translationX: leftTwoPathTranslation.x, y: leftTwoPathTranslation.y)
            let rightTransform = CGAffineTransform(translationX: rightTwoPathTranslation.x, y: rightTwoPathTranslation.y)
            replicatedPath.addPath(path, transform: leftTransform)
            replicatedPath.addPath(path, transform: rightTransform)
        } else {
            let leftTransform = CGAffineTransform(translationX: leftThreePathTranslation.x, y: leftThreePathTranslation.y)
            let rightTransform = CGAffineTransform(translationX: rightThreePathTranslation.x, y: rightThreePathTranslation.y)
            replicatedPath.addPath(path)
            replicatedPath.addPath(path, transform: leftTransform)
            replicatedPath.addPath(path, transform: rightTransform)
        }
        return replicatedPath
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
