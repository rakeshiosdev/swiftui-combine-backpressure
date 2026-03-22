//
//  DashboardView.swift
//  StreamControlEngine
//
//  Created by Rakesh's MacBook on 21/03/26.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @FocusState private var isSearchfocused: Bool
    @State private var showLog = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    searchHeader
                    statsBar
                    if showLog { logSection }
                }
                .padding(.bottom, 32)
            }
            .navigationTitle("Stream Rate Control")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(showLog ? "Hide Log" : "Call Log") {
                        withAnimation(.spring(duration: 0.35)) { showLog.toggle() }
                    }
                    .font(.caption)
                }
                
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(role: .destructive) {
//                        withAnimation { viewModel.resetStats() }
//                    } label: {
//                        Label("Reset", systemImage: "arrow.counterclockwise")
//                            .font(.caption)
//                    }
//                }
            }
        }
    }
    
    //MARK: - Search Header
    
    private var searchHeader: some View {
        VStack(spacing: 12) {
            // Mode segmented picker
            Picker("Backpressure Model", selection: $viewModel.selectedMode) {
                ForEach(BackpressureMode.allCases) { mode in
                    Text(mode.label).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: viewModel.selectedMode) { _, _ in
                viewModel.resetStats()
            }
            
            // Description of the currently selected mode
            HStack(spacing: 6) {
                Image(systemName: viewModel.selectedMode.systemIcon)
                    .foregroundStyle(viewModel.selectedMode.accentColor)
                    .shadow(color: .red.opacity(0.4), radius: 8, x: 0, y: 4)
                
                Text(viewModel.selectedMode.description)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 2)
            .animation(.easeOut(duration: 0.25), value: viewModel.selectedMode)
            
            // Search TextField
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField(
                        "",
                        text: $viewModel.searchText,
                        prompt: Text("Search...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    )
                    .focused($isSearchfocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.search)
                
                if !viewModel.searchText.isEmpty {
                    Button {
                        withAnimation { viewModel.searchText = "" }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(11)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(.rect(cornerRadius: 12))
        }
        .padding()
    }
    
    // MARK: – Stats Bar

    private var statsBar: some View {
        HStack(spacing: 0) {
            statCell(
                value: "\(viewModel.apiCallCount)",
                label: "API Calls",
                icon:  "arrow.up.arrow.down.circle.fill",
                color: viewModel.selectedMode.accentColor
            )
            Rectangle()
                .fill(Color(.separator))
                .frame(width: 1, height: 44)
            statCell(
                value: viewModel.selectedMode.label,
                label: "Mode",
                icon:  viewModel.selectedMode.systemIcon,
                color: viewModel.selectedMode.accentColor
            )
        }
        .padding(.vertical, 4)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(.rect(cornerRadius: 16))
        .padding(.horizontal)
        .animation(.spring(duration: 0.3), value: viewModel.apiCallCount)
        .animation(.easeInOut(duration: 0.2), value: viewModel.selectedMode)
    }

    private func statCell(value: String, label: String, icon: String, color: Color) -> some View {
        VStack(spacing: 3) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title3)
            Text(value)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(color)
                .contentTransition(.numericText())
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text(label)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
    }
    
    // MARK: – Call Log Section

    private var logSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Call Log")
                    .font(.headline)
                    .padding(.leading)
                Spacer()
                Text("newest first")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.trailing)
            }

            if viewModel.callLog.isEmpty {
                placeholder(icon: "doc.text", text: "No calls recorded yet")
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.callLog) { entry in
                        LogEntryRow(entry: entry)
                        Divider().padding(.leading, 12)
                    }
                }
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(.rect(cornerRadius: 14))
                .padding(.horizontal)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.callLog)
    }
    
    // MARK: – Helpers
    private func placeholder(icon: String, text: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.secondary.opacity(0.5))
            Text(text)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(44)
    }
}

#Preview {
    DashboardView()
}
