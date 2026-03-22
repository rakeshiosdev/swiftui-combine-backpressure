//
//  CallLogEntry.swift
//  StreamControlEngine
//
//  Created by Rakesh's MacBook on 21/03/26.
//

import Foundation

struct CallLogEntry: Identifiable, Equatable {
    let id = UUID()
    let index : Int
    let query : String
    let mode : BackpressureMode
    let timestamp = Date()

    var timeString: String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm:ss.SSS"
        return f.string(from: timestamp)
    }

    static func == (lhs: CallLogEntry, rhs: CallLogEntry) -> Bool {
        lhs.id == rhs.id
    }
}
