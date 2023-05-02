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

//                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    Text(speechRecognizer.transcript)
                        .font(.system(size: 36))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(25)
                        .frame(maxWidth: .infinity, alignment: .leading)

                }
                .padding(.bottom, 60)
                .padding(.top, 10)
                
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
                    .fontWeight(.bold)
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
