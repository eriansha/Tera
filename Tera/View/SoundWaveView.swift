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
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
    
    // 2
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = (max(10, CGFloat(level) + 50) / 2) - 4.9 // between 0.1 and 25
        
//        return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
        return CGFloat(level)
    }
    
    var body: some View {
        VStack {
             // 3
            HStack(spacing: 4) {
                // 4
                //                ForEach(mic.soundSamples, id: \.self) { level in
                //                    BarView(value: self.normalizeSoundLevel(level: level))
                //                }
                
                ForEach(0..<sizeList.count, id: \.self) { id in
                    BarView(value: self.normalizeSoundLevel(level: mic.soundSamples[id]), size: sizeList[id])
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
                .fill(Color.purple)
                // 3
                .frame(
                    width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples),
                    height: CGFloat(value * ((50 + size * 25) / 25))
                )
        }
    }
}

struct SoundWaveView_Previews: PreviewProvider {
    static var previews: some View {
        SoundWaveView()
    }
}
