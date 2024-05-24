//
//  ResultView.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss
    var result: Int
    @Binding var isGameOver: Bool
    var isNewHighScore: Bool
    var highScore: Int
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill()
                .opacity(0.5)
                .ignoresSafeArea()
            Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.resultBox))
            VStack{
                Spacer()
                Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.gameOverText))
                    .padding([.bottom], 32)
                if isNewHighScore {
                    Text("New Highscore!")
                        .font(.title)
                        .fontWeight(.bold)
                } else {
                    Text("Highscore: \(highScore) M")
                        .font(.title)
                        .fontWeight(.bold)
                }
                Text("Distance: \(result) M")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.bottom], 56)
                Button {
                    dismiss()
                    isGameOver = false
                    stopAudio()
                    playAudio(audioResourceId: ResourceHandler.sound.backgroundSound, isLoop: true)
                }label : {
                    Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.homeButton))
                }
                Spacer()
            }
            .padding(48)
        }
    }
}

#Preview {
    ResultView(result: 10, isGameOver: .constant(false), isNewHighScore: true, highScore: 10)
}
