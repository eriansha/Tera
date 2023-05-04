//
//  FullscreenTextModal.swift
//  Tera
//
//  Created by Ario Syahputra on 04/05/23.
//

import SwiftUI

struct FullscreenTextModal: View {
    
    @Binding var showSheet: Bool
    @ObservedObject var speechRecognizer: SpeechRecognizer
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    showSheet = false
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                })
                .padding(.top,30)
                .padding(.bottom,5)
                .padding(.horizontal,25)
            }
            ScrollView {
                Text(speechRecognizer.transcript)
                    .font(.system(size: 48))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.horizontal,30)
                    .presentationCornerRadius(29)
                    .presentationBackground {
                        Image("FullscreenBG")
                    }
            }
            .frame(height: 670)
        }
    }
}

//struct FullscreenTextModal_Previews: PreviewProvider {
//    static var previews: some View {
//        FullscreenTextModal()
//    }
//}
