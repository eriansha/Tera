//
//  RecordingView.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import SwiftUI

struct RecordingView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack {
            
            TextViewer(speechRecognizer: speechRecognizer).padding()
            
            DummyWave()
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
