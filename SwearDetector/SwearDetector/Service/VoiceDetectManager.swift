//
//  VoiceDetectManager.swift
//  SwearDetector
//
//  Created by JordannKo on 4/14/25.
//

import Foundation
import Speech
import AVFoundation

class VoiceDetectManager: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
  @Published var isDetected: Bool = false
  @Published var detectedWords: [String] = []
  @Published var recognizedText: String = ""
  
  private var recognizer: SFSpeechRecognizer?
  private let audioEngine = AVAudioEngine()
  private var request: SFSpeechAudioBufferRecognitionRequest?
  private var recognitionTask: SFSpeechRecognitionTask?

  private var badWords: [String] = []
  
  private var resetTimer: Timer?
  
  func startRecording(language: Language) throws {
    recognizer = SFSpeechRecognizer(locale: Locale(identifier: language.localeIdentifier))
    guard let recognizer = recognizer, recognizer.isAvailable else {
      return
    }
    
    request = SFSpeechAudioBufferRecognitionRequest()
    guard let recognitionRequest = request else {
      fatalError("Can't create request")
    }

    let inputNode = audioEngine.inputNode
    recognitionRequest.shouldReportPartialResults = true
    self.badWords = language.badWordList

    recognitionTask = recognizer.recognitionTask(with: recognitionRequest) {
      [weak self] result, error in
      guard let result = result else { return }
      let spokenText = result.bestTranscription.formattedString
      DispatchQueue.main.async {
        self?.recognizedText = spokenText
        self?.analyze(text: spokenText)
      }
    }

    let recordingFormat = inputNode.outputFormat(forBus: 0)
    
    inputNode.removeTap(onBus: 0)
    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
      (buffer, _) in
      recognitionRequest.append(buffer)
    }

    audioEngine.prepare()
    try audioEngine.start()
  }

  func stopRecording() {
    audioEngine.stop()
    request?.endAudio()
    recognitionTask?.cancel()
  }

  private func analyze(text: String) {
    let lowerText = text.lowercased()
    let detected = badWords.filter { lowerText.contains($0) }
    
    detectedWords = detected
    isDetected = !detected.isEmpty
    
    if isDetected {
      resetTimer?.invalidate()
      resetTimer = Timer.scheduledTimer(withTimeInterval: 7.0, repeats: false) { [weak self] _ in
        DispatchQueue.main.async {
          self?.isDetected = false
          self?.detectedWords = []
        }
      }
    }
  }
}
