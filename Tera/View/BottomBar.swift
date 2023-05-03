//
//  BottomBar.swift
//  teradev
//
//  Created by Ario Syahputra on 24/04/23.
//

import SwiftUI

struct BottomBar: View {
    public var mic: MicrophoneMonitor
    public var speechRecognizer: SpeechRecognizer
    
    enum Language: String, CaseIterable {
        case id = "id"
        case en = "en"
        
        func getLabel() -> String {
            switch(self) {
            case .id: return "Indonesia"
            case .en: return "English"
            }
        }
    }
    
    @Binding var isRecording: Bool
    @Binding var isPaused: Bool
    @State private var showingOptions = false
    @State private var selectionLanguage: String = "id"
    
    var body: some View {
            HStack{
                
                // Select Language Button
                Button {
                    showingOptions = true
                } label: {
                    ZStack {
                        Image(systemName: "globe")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height:30).foregroundColor(.accentColor)
                        
                        Text(selectionLanguage.uppercased())
                            .foregroundColor(.accentColor)
                            .font(.caption)
                            .bold()
                            .offset(x: 17, y: 17)
                    }
                }.confirmationDialog("Select language", isPresented: $showingOptions, titleVisibility: .visible) {
                    ForEach(Language.allCases, id: \.self) { lang in
                        Button(lang.getLabel()) {
                            selectionLanguage = lang.rawValue
                            speechRecognizer.changeLanguage(identifier: lang.rawValue)
                        }
                    }
                }.disabled(isRecording && !isPaused)


                // Record Button
                Button(action: {
                    if isRecording && !isPaused {
                        isPaused = true
                        speechRecognizer.stopTranscribing()
                        mic.stopMonitoring()
                    } else {
                        isRecording = true
                        isPaused = false
                        speechRecognizer.transcribe()
                        mic.startMonitoring()
                    }
                    
                }) {
                    ZStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 70, height: 70)
                            .overlay(
                                  Circle()
                                    .stroke(Color.accentColor, lineWidth: 1)
                              )
                        
                        Rectangle()
                            .foregroundColor(.accentColor)
                            .frame(width: isRecording && !isPaused ? 40 : 60, height: isRecording && !isPaused ? 40 : 60)
                            .cornerRadius(isRecording && !isPaused ? 10 : 30)
                            .animation(Animation.easeIn(duration: 0.5), value: isRecording && !isPaused)
  
                    }
                }.padding(.horizontal,50)
                
                
                // Reset Button
                Button {
                    isRecording = false
                    isPaused = false
                    speechRecognizer.transcript = ""
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                                .scaledToFit()
                                .frame(width: 30, height:30).foregroundColor(.accentColor)
                }
                .disabled(isRecording && !isPaused)
                
            }
        }
}

//struct BottomBar_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomBar()
//    }
//}

