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
    @State var prevTranscript: String = ""
    @State var isPaused: Bool = false
    @State var isTextViewerDimmed: Bool = true
    @State var isEmptyStateDimmed: Bool = false
    
    let animateDuration: CGFloat = 0.2
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                TextViewer(
                    speechRecognizer: speechRecognizer,
                    prevTranscript: $prevTranscript
                )
                .padding()
                .opacity(isTextViewerDimmed ? 0 : 1)
                .scaleEffect(isTextViewerDimmed ? 0 : 1)
                .animation(Animation.linear(duration: animateDuration), value: isTextViewerDimmed)
                
                
                VStack {
                    LottieView(url: "EmptyStateAnimation")
                        .frame(width: 200, height: 200)
                        .scaleEffect(isEmptyStateDimmed ? 1 : 2)
                    
                    Text("For better accuracy, bring the phone closer to the audio source.")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.gray)
                        .scaleEffect(isEmptyStateDimmed ? 0.1 : 1)
                        .padding(.top, 25)
                        .padding(.horizontal, 40)
                }
                .opacity(isEmptyStateDimmed ? 0 : 1)
                .animation(Animation.linear(duration: animateDuration), value: isEmptyStateDimmed)
            }.onChange(of: isRecording) { newState in
                isTextViewerDimmed.toggle()
                isEmptyStateDimmed.toggle()
            }
            
            if isRecording {
                SoundWaveView(
                    mic: microphoneMonitor,
                    isRecording: $isRecording
                )
                .frame(maxHeight: 100)
//                .padding(.horizontal, 100)
            }
            
            Spacer()
            
            Divider()
                .padding(.horizontal, 16)
            
            BottomBar(
                mic: microphoneMonitor,
                speechRecognizer: speechRecognizer,
                isRecording: $isRecording,
                isPaused: $isPaused,
                prevTranscript: $prevTranscript
            ).padding(.vertical, 30)
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
