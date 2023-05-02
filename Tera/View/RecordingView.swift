//
//  RecordingView.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import SwiftUI

struct RecordingView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording: Bool = false
    
    var body: some View {
        VStack {            
            TextViewer(speechRecognizer: speechRecognizer).padding()
            
            if isRecording {
                SoundWaveView()
            }
            
            Divider().frame(width: 300).padding(.vertical,20)
            
            BottomBar(speechRecognizer: speechRecognizer)
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
