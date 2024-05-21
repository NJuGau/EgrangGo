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
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill()
                .opacity(0.5)
                .ignoresSafeArea()
            Image(uiImage: UIImage(imageLiteralResourceName: "ResultBox"))
            VStack{
                Spacer()
                Image(uiImage: UIImage(imageLiteralResourceName: "GameOver"))
                    .padding(24)
                Text("Distance: \(result) M")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    dismiss()
                    isGameOver = false
                    playAudio(audioResourceId: ResourceHandler.sound.backgroundSound, isLoop: true)
                }label : {
                    Image(uiImage: UIImage(imageLiteralResourceName: "Home"))
                }
                Spacer()
            }
            .padding(48)
        }
    }
}

#Preview {
    ResultView(result: 10, isGameOver: .constant(false))
}
