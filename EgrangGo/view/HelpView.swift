//
//  HelpView.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 23/05/24.
//

import SwiftUI
import AVKit

struct HelpView: View {
    @Binding var isShowingHelp: Bool
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "TutorialWalking", withExtension: "mov")!)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill()
                .opacity(0.5)
                .ignoresSafeArea()
            HStack{
                Spacer()
                ZStack {
                    Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.helpBox))
                    VStack{
                        Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.helpText))
                            .padding([.bottom], 24)
                        ScrollView {
                            HelpText(text: "1. Welcome to EgrangGo! your objective is to get the farthest distance possible within the time limit using egrang.")
                            HelpText(text: "2. You may move your egrang using the provided joysticks to move forward.")
                            VideoPlayer(player: player)
                                .disabled(true)
                                .onAppear {
                                    player.play()
                                                   NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in
                                                       player.seek(to: .zero)
                                                       player.play()
                                                   }
                                               }
                                    .frame(width: 600, height: 337, alignment: .center)
                                    .padding(16)
                            HelpText(text: "3. Beware! there are obstacles such as rock that can make it harder for you to control your egrang.")
                            Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.rock))
                                .resizable()
                                .frame(width: 100, height: 60)
                                .padding([.bottom], 16)
                            HelpText(text: "4. Have fun!")
                        }
                        .frame(width: 700, height: 360, alignment: .centerFirstTextBaseline)
                    }
                }
                .padding([.trailing], 25)
                
                VStack{
                    Button {
                        isShowingHelp = false
                    } label: {
                        Image(uiImage: UIImage(imageLiteralResourceName: ResourceHandler.image.exitButton))
                    }
                    Spacer()
                }
            }
            .padding(20)
        }
    }
}

#Preview {
    HelpView(isShowingHelp: .constant(false))
}
