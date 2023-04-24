//
//  RecordingView.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import SwiftUI

struct RecordingView: View {
    @StateObject var speechModel = SpeechModel()
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
                // speechRecognizer.language = value
//                let newObj = SpeechRecognizer(language: value)
//                speechRecognizer = newObj
                speechModel.changeLangunage(identifier: value)
            }
            
            
            VStack {
                Text(speechModel.speechRecognizer.transcript)
                    .padding()
                Text(languageChange)
                Button(action: {
                    
                    if !isRecording {
                        speechModel.speechRecognizer.transcribe()
                        
                    } else {
                        speechModel.speechRecognizer.stopTranscribing()
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
