//
//  LogEntryRow.swift
//  StreamControlEngine
//
//  Created by Rakesh's MacBook on 21/03/26.
//

import SwiftUI

struct LogEntryRow: View {
    let entry: CallLogEntry

    var body: some View {
        HStack(spacing: 10) {
            Text("#\(entry.index)")
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundColor(entry.mode.accentColor)
                .frame(width: 36, alignment: .trailing)

            VStack(alignment: .leading, spacing: 2) {
                Text(entry.query.isEmpty ? "(empty)" : "\"\(entry.query)\"")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(.primary)
                Text(entry.timeString)
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Mode badge
            Text(entry.mode.label)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(entry.mode.accentColor.opacity(0.15))
                .foregroundColor(entry.mode.accentColor)
                .clipShape(.rect(cornerRadius: 5))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    let entry = CallLogEntry(index: 3, query: "apple", mode: .debounce)
    return LogEntryRow(entry: entry)
        .padding()
}
