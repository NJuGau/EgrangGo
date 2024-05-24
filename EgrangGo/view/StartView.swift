//
//  StartView.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var viewModel = StartViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                HStack {
                    VStack {
                        Spacer()
                        Button {
                            viewModel.isShowingHelp = true
                        }label: {
                            Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.helpButton))
                        }
                    }.padding([.trailing], 30)
                        .padding([.leading, .bottom], 20)
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
                    Spacer()
                }
                if viewModel.isShowingHelp {
                    HelpView(isShowingHelp: $viewModel.isShowingHelp)
                }
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
