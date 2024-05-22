//
//  StartView.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                VStack{
                    Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.gameTitle))
                    Spacer()
                    NavigationLink{
                        GameView()
                    }label: {
                        Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.startButton))
                    }
                }
                .padding(128)
            }
        }
        .onAppear(){
            playAudio(audioResourceId: ResourceHandler.sound.backgroundSound, isLoop: true)
        }
    }
}

#Preview {
    StartView()
}
