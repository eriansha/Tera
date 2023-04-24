//
//  Error.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import Foundation

enum RecognizerError: Error {
    case nilRecognizer
    case unauthorizedToRecognize
    case notPermittedRecord
    case unavailableRecognizer
    
    var message: String {
        switch self {
        case .nilRecognizer: return "Unable to initialize speech recognizer"
        case .unauthorizedToRecognize: return "Unauthorized to recognize the speech"
        case .notPermittedRecord: return "Not permitted to record audio"
        case .unavailableRecognizer: return "Recognizer is unavailable"
        }
    }
}
