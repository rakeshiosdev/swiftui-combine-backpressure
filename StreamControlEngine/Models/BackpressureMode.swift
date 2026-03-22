//
//  BackpressureMode.swift
//  StreamControlEngine
//
//  Created by Rakesh's MacBook on 21/03/26.
//

import SwiftUI

enum BackpressureMode: Int, CaseIterable, Identifiable {
    case none = 0
    case debounce
    case throttle
    
    var id: Int { self.rawValue }
    
    var label: String {
        switch self {
        case .none:
            return "Instant"
        case .debounce:
            return "Debounce"
        case .throttle:
            return "Throttle"
        }
    }
    
    var description: String {
        switch self {
        case .none:
            return "Triggers an API call on every keystroke with no rate limiting."
        case .debounce:
            return "Delays the API call until typing stops for 1 second."
        case .throttle:
            return "Limits API calls to at most one request per second, regardless of typing speed."
        }
    }
    
    var accentColor: Color {
        switch self {
        case .none:
            return .red
        case .debounce:
            return .blue
        case .throttle:
            return .green
        }
    }
    
    var systemIcon: String {
        switch self {
        case .none:
            return "bolt.fill"
        case .debounce:
            return "timer"
        case .throttle:
            return "gauge.with.dots.needle.33percent"
        }
    }
}


