//
//  BackgroundView.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [Color.primary70, Color.secondary90, Color.secondary70],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
