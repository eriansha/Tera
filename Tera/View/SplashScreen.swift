//
//  SplashScreen.swift
//  Tera
//
//  Created by Ario Syahputra on 03/05/23.
//

import SwiftUI

struct SplashScreen: View {
    var bgName: String
    
    var body: some View {
        
        ZStack{
            Image(bgName).resizable().ignoresSafeArea(.all)
            ZStack {
                Image("SplashLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 171.19, height: 100)
            }
        }
        
        
    }
}

//struct SplashScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashScreen()
//    }
//}
