//
//  LogoView.swift
//  SwiftUIvsUIKit
//
//  Created by Teacher on 15.04.2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("capybara")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .frame(width: 200, height: 200)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
