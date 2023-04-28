//
//  TextViewer.swift
//  teradev
//
//  Created by Ario Syahputra on 24/04/23.
//

import SwiftUI

struct TextViewer: View {
    @ObservedObject var speechRecognizer: SpeechRecognizer
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            //Recognition TextView & Background
            ZStack {
                Image("TextViewerBG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)

                ScrollView{

                    Text(speechRecognizer.transcript)
                        .font(.system(size: 36))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(35)
                        .frame(maxWidth: .infinity, alignment: .leading)

                }
                
            }
            .frame(width: 358, height: 470)
            .cornerRadius(15)
            .shadow(
                color: Color.black.opacity(0.2),
                radius: 10
            )
            
            //Button FullScreen
            Button(action: {

            }) {
                Image(systemName: "viewfinder")
                    .frame(width: 30, height: 29)
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                    .padding(.horizontal,25)
                    .padding(.vertical,25)
            }
        }
    }
}

struct TextViewer_Previews: PreviewProvider {
    static var previews: some View {
        TextViewer(speechRecognizer: SpeechRecognizer())
    }
}
