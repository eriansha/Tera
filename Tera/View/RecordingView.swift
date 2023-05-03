//
//  RecordingView.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import SwiftUI

struct RecordingView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @StateObject var microphoneMonitor = MicrophoneMonitor(numberOfSamples: 37)
    @State var isRecording: Bool = false
    @State var isPaused: Bool = false
    @State var isTextViewerDimmed: Bool = true
    @State var isEmptyStateDimmed: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                TextViewer(speechRecognizer: speechRecognizer)
                    .padding()
                    .opacity(isTextViewerDimmed ? 0 : 1)
                    .scaleEffect(isTextViewerDimmed ? 0 : 1)
                    .animation(Animation.linear(duration: 0.5), value: isTextViewerDimmed)
                
                
                VStack {
                    LottieView(url: "EmptyStateAnimation")
                        .frame(width: 200, height: 200)
                        .scaleEffect(isEmptyStateDimmed ? 1 : 2)
                    
                    Text("Start recording")
                        .font(.body)
                        .foregroundColor(.gray)
                        .scaleEffect(isEmptyStateDimmed ? 0.1 : 1)
                }
                .opacity(isEmptyStateDimmed ? 0 : 1)
                .animation(Animation.linear(duration: 0.5), value: isEmptyStateDimmed)
            }.onChange(of: isRecording) { newState in
                isTextViewerDimmed.toggle()
                isEmptyStateDimmed.toggle()
            }
            
            Spacer()
        
            SoundWaveView(
                mic: microphoneMonitor,
                isRecording: $isRecording
            )
            .frame(height: 100)
            .padding(.horizontal, 100)
            
            Spacer()
            
            BottomBar(
                mic: microphoneMonitor,
                speechRecognizer: speechRecognizer,
                isRecording: $isRecording,
                isPaused: $isPaused
            ).padding(.bottom, 20)
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
