//
//  hasPermissionToRecord.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import Foundation
import AVFoundation

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
