//
//  SpeechRecognizer.swift
//  Tera
//
//  Created by Ivan on 24/04/23.
//

import Foundation
import AVFoundation
import Speech
import SwiftUI

/** Speech recognizer abstraction made by Apple's Speech Framework */
class SpeechRecognizer: ObservableObject {
    @Published var transcript: String = ""
    
    /** speech recognizer langunage choosing */
    public var language: String
    
    /** An object that manages a graph of audio nodes, controls playback, and configures real-time rendering constraints. */
    private var audioEngine: AVAudioEngine?
    
    /** A request to recognize speech from captured audio content, such as audio from the device’s microphone. */
    private var request: SFSpeechAudioBufferRecognitionRequest?
    
    /** Represent single task object for monitoring speech recognition progress */
    private var task: SFSpeechRecognitionTask?
    
    /** Speech framework recognition service */
    private var recognizer: SFSpeechRecognizer?
    
    /** Parse Speech Recognizer error into human-readable format */
    private func speakError(_ error: Error) {
        var errorMessage: String = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        
        self.transcript = "<< \(errorMessage) >>"
    }
    
    /** reset speech recognizer */
    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    /** Prepare engine to record */
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        /**
            An AVAudioEngine contains a group of connected AVAudioNodes ("nodes"), each of which performs
            an audio signal generation, processing, or input/output task.
         */
        let audioEngine = AVAudioEngine()
        
        /** init recognize speech to capture audio content from device's microphone */
        let request = SFSpeechAudioBufferRecognitionRequest()
        /** assign this value get intermediate result for each utterance since we want to create real time transcription */
        request.shouldReportPartialResults = true
        
        /** Configure the audio session for the app: */
        /** 1. get shared audio session instance (singleton) */
        let audioSession = AVAudioSession.sharedInstance()
        /**
            2. setup necessary configuration
            set record category as audio session (this category will silence the playback audio).
            set measurement mode as audio session identifier
            set duckOthers to reduce the volume of other audio session while audio from this session plays
         */
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        /** 3. set activate audio session, but it won't start recording */
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        /**
            The input node represents the current audio input path, which can be the device’s built-in microphone or a microphone connected to a set of headphones.
         */
        let inputNode = audioEngine.inputNode
        
        /** Configure the microphone input. */
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        /**
            To begin recording, the app installs a tap on the input node and starts up the audio engine, which begins collecting samples into an internal buffer. When a buffer is full, the audio engine calls the provided block. The app’s implementation of that block passes the samples directly to the request object’s append(_:) method, which accumulates the audio samples and delivers them to the speech recognition system.
         */
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in request.append(buffer)
        }
        
        /**
            This method prepares the audio engine for playback by initializing its nodes, setting up their connections, and allocating resources. You should call this method before starting the engine to ensure that everything is set up properly.
         */
        audioEngine.prepare()
        
        /**
            This method starts the audio engine and begins playback. You should call this method after calling prepare() and when you're ready to start playing audio.
         */
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    private func speak(_ message: String) {
        transcript = message
    }
    
    /**
    Initializes a new speech recognizer.
     */
    init(language: String = "id") {
        
        self.language = language
        
        /** Initialize Speech Framework from Apple SDK */
        recognizer = SFSpeechRecognizer(locale: Locale(identifier: self.language))!
        
        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.unauthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedRecord
                }
            } catch {
                speakError(error)
            }
        }
    }
    
    
    
    deinit {
        reset()
    }
    
    func changeLanguage(identifier: String) {
        reset()
        
        self.language = identifier
        recognizer = SFSpeechRecognizer(locale: Locale(identifier: self.language))!
    }
    
    /** Create a recognition task for the speech recognition session. */
    func transcribe() {
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            self?.speakError(RecognizerError.unavailableRecognizer)
            return
        }
        
        do {
            let (audioEngine, request) = try Self.prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            
            self.task = recognizer?.recognitionTask(with: request) { result, error in
                let receiveFinalResult = result?.isFinal ?? false
                let receiveError = error != nil
                
                if receiveFinalResult || receiveError {
                    audioEngine.stop()
                    audioEngine.inputNode.removeTap(onBus: 0)
                }
                
                if let result = result {
                    self.speak(result.bestTranscription.formattedString)
                }
            }
        } catch {
            self.reset()
            self.speakError(error)
        }
    }
    
    /** To stop transcribing process */
    func stopTranscribing() {
        reset()
    }
}
