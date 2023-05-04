//
//  SplashScreen.swift
//  Tera
//
//  Created by Ario Syahputra on 03/05/23.
//

import SwiftUI

struct SplashScreen: View {
    
    var body: some View {
        
        ZStack {
            Image(systemName: "ear.and.waveform")
                .foregroundColor(.accentColor)
                .font(.system(size: 80))
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
