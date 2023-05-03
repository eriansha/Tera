//
//  SplashScreen.swift
//  Tera
//
//  Created by Ario Syahputra on 03/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        
        if isActive{
            RecordingView()
        }else{
            ZStack {
                Image(systemName: "ear.and.waveform")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 80))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
