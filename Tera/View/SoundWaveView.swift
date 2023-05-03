//
//  SoundWaveView.swift
//  Tera
//
//  Created by Muhammad Fauzul Akbar on 01/05/23.
//

import SwiftUI

let numberOfSamples = 37
let sizeList: [CGFloat] = [1,2,3,0,5,3,4,0,3,3,2,3,5,8,7,6,7,4,0,3,3,2,3,4,8,7,6,7,5,3,0,4,5,0,3,2,1]

struct SoundWaveView: View {
    // 1
    @ObservedObject public var mic: MicrophoneMonitor
    @Binding public var isRecording: Bool
    
    // 2
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        
        /**
          guard the normalization to prevent auto scalling
          at the first time active the microphone monitor
         */
        if level == 0 {
            return CGFloat(0.1)
        }
        
        let level = max(0.2, CGFloat(level) + 40) / 2 // 0.1 to 18

        return CGFloat(level)
    }
    
    var body: some View {
        VStack {
             // 3
            HStack(spacing: 4) {
                if isRecording {
                    ForEach(0..<sizeList.count, id: \.self) { id in
                        BarView(value: self.normalizeSoundLevel(level: mic.soundSamples[id]), size: sizeList[id])
                    }
                } else {
                    ForEach(0..<sizeList.count, id: \.self) { id in
                        BarView(value: 0.1, size: 1)
                    }
                }
            }
        }
    }
}

struct BarView: View {
   // 1
    var value: CGFloat
    
    var size: CGFloat

    var body: some View {
        ZStack {
           // 2
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.accentColor)
                // 3
                .animation(Animation.easeIn(duration: 0.05), value: value)
                .frame(
                    width: (UIScreen.main.bounds.width - 34 - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples),
                    /**
                     make all the bar sound wave has the same height when no sound detected
                     */
                    height: (value == 0.1 ?
                             CGFloat(value * ((30 + 1 * 20) / 20)) :
                        CGFloat(value * ((30 + size * 20) / 20))
                        )
                )
        }
    }
}

struct SoundWaveView_Previews: PreviewProvider {
    static var previews: some View {
        SoundWaveView(mic: MicrophoneMonitor(numberOfSamples: 37), isRecording: .constant(true))
    }
}
