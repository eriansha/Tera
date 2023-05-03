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
    @State private var showingOptions = false
    @State private var selectionLanguage: String = "en"
    
    var body: some View {
            HStack{
                
                //Select Language Button
                Button {
                    showingOptions = true
                } label: {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height:30).foregroundColor(.accentColor)
                }.confirmationDialog("Select Language", isPresented: $showingOptions, titleVisibility: .visible) {
                    ForEach(Language.allCases, id: \.self) { lang in
                        Button(lang.getLabel()) {
                            selectionLanguage = lang.rawValue
                            speechRecognizer.changeLanguage(identifier: lang.rawValue)
                        }
                    }
                }.disabled(isRecording)


                //Record Button
                Button(action: {
                    if isRecording {
                        isRecording = false
                        speechRecognizer.stopTranscribing()
                        mic.stopMonitoring()
                    } else {
                        isRecording = true
                        speechRecognizer.transcribe()
                        mic.startMonitoring()
                    }
                    
                }) {
                    ZStack{
//                        if isRecording{
//                            RoundedRectangle(cornerRadius: 5).foregroundColor(.accentColor)
//                                .frame(width: 40, height: 40).padding(15)
//                        }else{
//                            Circle()
//                                .foregroundColor(.accentColor)
//                                .frame(width: 60, height: 60).padding(5)
//
//                        }
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 70, height: 70)
                            .overlay(
                                  Circle()
                                    .stroke(Color.accentColor, lineWidth: 1)
                              )
                        
                        Rectangle()
                            .foregroundColor(.accentColor)
                            .frame(width: isRecording ? 30 : 40, height: isRecording ? 30 : 40)
                            .cornerRadius(isRecording ? 15 : 0)
                            .animation(Animation.easeIn(duration: 0.5), value: isRecording)
                            .padding(15)
  
                    }
                }.padding(.horizontal,50)
                
                
                //Reset Button
                Button {
                    speechRecognizer.transcript = ""
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                                .scaledToFit()
                                .frame(width: 30, height:30).foregroundColor(.accentColor)
                }
                .disabled(isRecording)
                
            }
        }
}

//struct BottomBar_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomBar()
//    }
//}

