//
//  RecordingView.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import SwiftUI

struct RecordingView: View {
    @StateObject var speechRecognizer = SpeechRecognizer(language: "id")
    @State private var isRecording: Bool = false
    @State var languageChange = "id"
    let languages = ["id","en"]
    
    
    var body: some View {
        HStack{
            Picker(selection : $languageChange ,label:Text("select language")){
                ForEach(languages, id: \.self)
                { lang in Text(lang).tag(lang)}
            }
            .onChange(of: languageChange) { value in
                speechRecognizer.changeLanguage(newLanguage: value)
            }
            
            
            VStack {
                Text(speechRecognizer.transcript)
                    .padding()
                
                Button(action: {
                    
                    if !isRecording {
                        speechRecognizer.transcribe()
                    } else {
                        speechRecognizer.stopTranscribing()
                    }
                    
                    isRecording.toggle()
                }) {
                    Text(isRecording ? "Stop" : "Record")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(isRecording ? Color.red : Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
