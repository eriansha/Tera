//
//  hasAuthorizationToRecognize.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import Foundation
import Speech

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}
