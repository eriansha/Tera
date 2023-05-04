//
//  ContentView.swift
//  Tera
//
//  Created by Ivan on 18/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            if isActive{
                RecordingView()
            }else{
                SplashScreen(isDarkMode: colorScheme == .dark)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
