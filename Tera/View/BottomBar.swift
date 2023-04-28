//
//  BottomBar.swift
//  teradev
//
//  Created by Ario Syahputra on 24/04/23.
//

import SwiftUI

struct BottomBar: View {
    public var speechRecognizer: SpeechRecognizer
    
    @State private var isRecording: Bool = false
    @State private var showingOptions = false
    @State private var selectionLanguage = "None"
    
    var body: some View {
            HStack{
                
                //Select Language Button
                Button {
                    showingOptions = true
                } label: {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height:30).foregroundColor(Color("Purple"))
                }.confirmationDialog("Select Language", isPresented: $showingOptions, titleVisibility: .visible) {
                    ForEach(["Bahasa Indonesia", "English"], id: \.self) { lang in
                        Button(lang) {
                            selectionLanguage = lang
                        }
                    }
                }

                //Record Button
                Button(action: {
                    if isRecording {
                        isRecording = false
                        speechRecognizer.stopTranscribing()
                    } else {
                        isRecording = true
                        speechRecognizer.transcribe()
                    }
                    
                }) {
                    ZStack{
                        if isRecording{
                            RoundedRectangle(cornerRadius: 5).fill(Color("Purple"))
                                .frame(width: 40, height: 40).padding(15)
                        }else{
                            Circle()
                                .fill(Color("Purple"))
                                .frame(width: 60, height: 60).padding(5)
            
                        }
  
                    }.overlay(
                        Circle()
                            .stroke(Color("Purple"), lineWidth: 2)
                    )
                }.padding(.horizontal,50)
                
                
                //Reset Button
                Button {
                    speechRecognizer.transcript = ""
                    print("Reset!")
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                                .scaledToFit()
                                .frame(width: 30, height:30).foregroundColor(Color("Purple"))
                }
                
            }
        }
}

//struct BottomBar_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomBar()
//    }
//}

