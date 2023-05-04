//
//  TextViewer.swift
//  teradev
//
//  Created by Ario Syahputra on 24/04/23.
//

import SwiftUI

struct TextViewer: View {
    @ObservedObject var speechRecognizer: SpeechRecognizer
    @State var showSheet = false
    @Binding var prevTranscript: String
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            //Recognition TextView & Background
            ZStack {
                Image("TextViewerBG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    ScrollView {
                        Text(
                            prevTranscript.isEmpty
                                ? speechRecognizer.transcript
                                : prevTranscript + " " + speechRecognizer.transcript
                        )
                            .font(.system(size: 36))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: 370)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showSheet = true
                        }) {
                            Image(systemName: "viewfinder")
                                .frame(width: 30, height: 29)
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.horizontal,17)
                        }
                        //Fullscreen Modal
                        .sheet(isPresented: $showSheet) {
                            FullscreenTextModal(showSheet: $showSheet, speechRecognizer: speechRecognizer)
                        }
                    }.padding(.bottom, -20)
                    
                }
                
            }
            .frame(width: 358, height: 470)
            .cornerRadius(15)
            .shadow(
                color: Color.black.opacity(0.2),
                radius: 10
            )
        }.onAppear {
            UIScrollView.appearance().indicatorStyle = .white
        }
    }
}

struct TextViewer_Previews: PreviewProvider {
    static var previews: some View {
        TextViewer(speechRecognizer: SpeechRecognizer(), prevTranscript: .constant("Test"))
    }
}
