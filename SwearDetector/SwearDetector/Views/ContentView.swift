//
//  ContentView.swift
//  SwearDetector
//
//  Created by JordannKo on 4/13/25.
//

import SwiftUI

struct ContentView: View {
  @State var isRecording: Bool = false
  @State var showPrivacyPolicy: Bool = false
  @State var showTermsOfService: Bool = false
  @StateObject var detectManager: VoiceDetectManager = .init()
  @State private var selectedLanguage: Language = .english
  
  var body: some View {
    ZStack {
      LinearGradient(
        colors: [detectManager.isDetected ? Color.red : Color.green, detectManager.isDetected ? Color.yellow : Color.blue],
        startPoint: .topTrailing,
        endPoint: .bottomLeading
      )
      .ignoresSafeArea()
      .animation(.easeInOut(duration: 0.7), value: detectManager.isDetected)
      
      VStack(alignment: .leading) {
        HStack {
          Menu {
            ForEach(Language.allCases) { lang in
              Button(action: {
                selectedLanguage = lang
              }) {
                HStack {
                  Text(lang.rawValue)
                  Spacer()
                  if selectedLanguage == lang {
                    Image(systemName: "checkmark")
                  }
                }
              }
            }
          } label: {
            Image(systemName: "line.3.horizontal")
              .font(.title)
              .foregroundColor(.white)
              .padding()
          }
          
          Spacer()
          
          Menu {
            Button {
              showPrivacyPolicy = true
            } label: {
              Text("개인정보처리방침")
            }
            Button {
              showTermsOfService = true
            } label: {
              Text("이용약관")
            }
          } label: {
            Image(systemName: "ellipsis")
              .font(.title2)
              .foregroundColor(.white)
              .padding()
              .rotationEffect(.degrees(90))
          }
        }
        Spacer()
      }

      Circle()
        .fill(.ultraThinMaterial)
        .frame(width: 300, height: 200)
        .overlay(
          VStack(spacing: 8) {
            Image(systemName: isRecording ? "stop.circle.fill" : "waveform.circle.fill")
              .font(.system(size: 40))
              .foregroundColor(.white.opacity(0.9))
            
            Text(isRecording ? "탭하여 중지" : "탭하여 시작")
              .foregroundStyle(.white)
              .padding(.top, 10)
          }
        )
        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 5)
        .overlay(
          Circle()
            .strokeBorder(LinearGradient(colors: [.white.opacity(0.4), .clear], startPoint: .top, endPoint: .bottom), lineWidth: 2)
        )
        .scaleEffect(isRecording ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isRecording)
        .onTapGesture {
          isRecording.toggle()
          if isRecording {
            try? detectManager.startRecording(language: selectedLanguage)
          } else {
            detectManager.stopRecording()
          }
        }
      
        if isRecording {
          if detectManager.isDetected {
            Image(systemName: "exclamationmark.circle")
              .resizable()
              .offset(y: -200)
              .frame(width: 50, height: 50)
              .foregroundStyle(.white)
          } else {
            Text("음성 인식 중...")
              .font(.system(size: detectManager.isDetected ? 30 : 20))
              .foregroundStyle(.white)
              .offset(y: -200)
          }
        }
    }
    .sheet(isPresented: $showPrivacyPolicy) {
      AppPolicyView(appPolicy: .privacyPolicy)
    }
    .sheet(isPresented: $showTermsOfService) {
      AppPolicyView(appPolicy: .termsOfService)
    }
  }
}

#Preview {
  ContentView()
}
