//
//  SpeechFramework.swift
//  Tera
//
//  Created by Felix Natanael on 02/05/23.
//

import Foundation

class SpeechModel: ObservableObject {
    @Published var speechRecognizer = SpeechRecognizer()
    
    func changeLangunage(identifier: String) {
        speechRecognizer = SpeechRecognizer(language: identifier)
        self.objectWillChange.send()
    }
}
