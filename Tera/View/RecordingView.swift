//
//  RecordingView.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import SwiftUI

struct RecordingView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @StateObject var mic = MicrophoneMonitor(numberOfSamples: 37)
    @State var isRecording: Bool = false
    @State var prevTranscript: String = ""
    
    var body: some View {
        VStack {
            TextViewer(speechRecognizer: speechRecognizer, prevTranscript: $prevTranscript).padding()
        
            SoundWaveView(mic: mic, isRecording: $isRecording)
                .frame(height: 100)
                .padding(.bottom, 10)
            
            BottomBar(mic: mic, speechRecognizer: speechRecognizer, isRecording: $isRecording, prevTranscript: $prevTranscript)
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
