//
//  Localization.swift
//  SwearDetector
//
//  Created by JordannKo on 4/14/25.
//

import Foundation

enum Language: String, CaseIterable, Identifiable {
  case arabic = "🇸🇦 العربية"
  case czech = "🇨🇿 Čeština"
  case danish = "🇩🇰 Dansk"
  case german = "🇩🇪 Deutsch"
  case english = "🇺🇸 English"
  case spanish = "🇪🇸 Español"
  case finnish = "🇫🇮 Suomi"
  case french = "🇫🇷 Français"
  case hebrew = "🇮🇱 עברית"
  case hindi = "🇮🇳 हिन्दी"
  case hungarian = "🇭🇺 Magyar"
  case indonesian = "🇮🇩 Bahasa Indonesia"
  case italian = "🇮🇹 Italiano"
  case japanese = "🇯🇵 日本語"
  case korean = "🇰🇷 한국어"
  case malay = "🇲🇾 Bahasa Melayu"
  case dutch = "🇳🇱 Nederlands"
  case norwegian = "🇳🇴 Norsk"
  case polish = "🇵🇱 Polski"
  case portuguese = "🇵🇹 Português"
  case romanian = "🇷🇴 Română"
  case russian = "🇷🇺 Русский"
  case swedish = "🇸🇪 Svenska"
  case thai = "🇹🇭 ภาษาไทย"
  case turkish = "🇹🇷 Türkçe"
  case ukrainian = "🇺🇦 Українська"
  case vietnamese = "🇻🇳 Tiếng Việt"
  case chinese = "🇨🇳 中文"

  var id: String { self.rawValue }
}

extension Language {
  var localeIdentifier: String {
    switch self {
      case .arabic: return "ar-SA"
      case .czech: return "cs-CZ"
      case .danish: return "da-DK"
      case .german: return "de-DE"
      case .english: return "en-US"
      case .spanish: return "es-ES"
      case .finnish: return "fi-FI"
      case .french: return "fr-FR"
      case .hebrew: return "he-IL"
      case .hindi: return "hi-IN"
      case .hungarian: return "hu-HU"
      case .indonesian: return "id-ID"
      case .italian: return "it-IT"
      case .japanese: return "ja-JP"
      case .korean: return "ko-KR"
      case .malay: return "ms-MY"
      case .dutch: return "nl-NL"
      case .norwegian: return "no-NO"
      case .polish: return "pl-PL"
      case .portuguese: return "pt-PT"
      case .romanian: return "ro-RO"
      case .russian: return "ru-RU"
      case .swedish: return "sv-SE"
      case .thai: return "th-TH"
      case .turkish: return "tr-TR"
      case .ukrainian: return "uk-UA"
      case .vietnamese: return "vi-VN"
      case .chinese: return "zh-CN"
    }
  }
}

extension Language {
  static func getDeviceLocale() -> Language {
    let preferredLanguages = Locale.preferredLanguages
    let primary = preferredLanguages.first ?? "en"

    if primary.hasPrefix("ko") {
      return .korean
    } else if primary.hasPrefix("ja") {
      return .japanese
    } else if primary.hasPrefix("zh") {
      return .chinese
    } else if primary.hasPrefix("es") {
      return .spanish
    } else if primary.hasPrefix("fr") {
      return .french
    } else if primary.hasPrefix("de") {
      return .german
    } else if primary.hasPrefix("ru") {
      return .russian
    } else if primary.hasPrefix("vi") {
      return .vietnamese
    } else if primary.hasPrefix("th") {
      return .thai
    } else if primary.hasPrefix("id") {
      return .indonesian
    } else if primary.hasPrefix("pt") {
      return .portuguese
    } else if primary.hasPrefix("it") {
      return .italian
    } else if primary.hasPrefix("tr") {
      return .turkish
    } else if primary.hasPrefix("uk") {
      return .ukrainian
    } else if primary.hasPrefix("ar") {
      return .arabic
    }

    return .english
  }
}

extension Language {
  var badWordList: [String] {
    switch self {
    case .arabic:
      return arabicWordList
    case .czech:
      return czechWordList
    case .danish:
      return danishWordList
    case .german:
      return germanWordList
    case .english:
      return englishWordList
    case .spanish:
      return spanishWordList
    case .finnish:
      return finnishWordList
    case .french:
      return frenchWordList
    case .hebrew:
      return hebrewWordList
    case .hindi:
      return hindiWordList
    case .hungarian:
      return hungarianWordList
    case .indonesian:
      return indonesianWordList
    case .italian:
      return italianWordList
    case .japanese:
      return japaneseWordList
    case .korean:
      return koreanWordList
    case .malay:
      return malayWordList
    case .dutch:
      return dutchWordList
    case .norwegian:
      return norwegianWordList
    case .polish:
      return polishWordList
    case .portuguese:
      return portugueseWordList
    case .romanian:
      return romanianWordList
    case .russian:
      return russianWordList
    case .swedish:
      return swedishWordList
    case .thai:
      return thaiWordList
    case .turkish:
      return turkishWordList
    case .ukrainian:
      return ukrainianWordList
    case .vietnamese:
      return vietnameseWordList
    case .chinese:
      return chineseWordList
    }
  }
}
