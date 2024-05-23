//
//  HelpText.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 23/05/24.
//

import SwiftUI

struct HelpText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.medium)
            .multilineTextAlignment(.leading)
            .frame(width: 650, alignment: .leading)
            .padding([.trailing], 16)
    }
}

#Preview {
    HelpText(text: "1. Welcome to EgrangGo! your objective is to get the farthest distance possible within the time limit using egrang.")
}
