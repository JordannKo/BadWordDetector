//
//  AppPolicyView.swift
//  SwearDetector
//
//  Created by JordannKo on 4/22/25.
//

import SwiftUI

enum AppPolicy {
  case privacyPolicy
  case termsOfService
  
  var title: String {
    switch self {
    case .privacyPolicy:
      return "개인정보처리방침"
    case .termsOfService:
      return "이용약관"
    }
  }
  
  var description: String {
    switch self {
    case .privacyPolicy:
      return privacyPolicyText
    case .termsOfService:
      return termsOfServiceText
    }
  }
}

struct AppPolicyView: View {
  let appPolicy: AppPolicy
  
  var body: some View {
    VStack {
      HStack {
        Text(appPolicy.title)
          .font(Font.pretendard(.bold, size: 24))
          .padding(.top, 25)
          .padding(.leading, 15)
        
        Spacer()
      }
      
      ScrollView {
        Text(appPolicy.description)
      }
      .padding(.horizontal, 15)
      .padding(.top, 5)
      .padding(.bottom, 50)
      .scrollIndicators(.hidden)
    }
  }
}

#Preview {
  AppPolicyView(appPolicy: .privacyPolicy)
}
