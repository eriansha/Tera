//
//  Button.swift
//  Tera
//
//  Created by Ivan on 19/04/23.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Button {
             print("Image tapped!")
         } label: {
             Text("Play")
         }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
