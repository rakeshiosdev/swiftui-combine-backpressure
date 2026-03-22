//
//  SearchViewModel.swift
//  StreamControlEngine
//
//  Created by Rakesh's MacBook on 21/03/26.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedMode: BackpressureMode = .none
    
    @Published private(set) var apiCallCount: Int = 0
    @Published private(set) var callLog: [CallLogEntry] = []
    
    private var pipelineSubscription: AnyCancellable?
    private var modeSubscription: AnyCancellable?
    
    init() {
        modeSubscription = $selectedMode
            .sink { [weak self] newMode in
                self?.resetStats()
                self?.buildPipeline(mode: newMode)
            }
    }
    
    private func buildPipeline(mode: BackpressureMode) {
        pipelineSubscription?.cancel()
        
        let base = $searchText
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .filter { !$0.isEmpty }
        
        let controlled: AnyPublisher<String, Never>
        
        switch mode {   // ← use the parameter, not self.selectedMode
        case .none:
            controlled = base.eraseToAnyPublisher()
            
        case .debounce:
            controlled = base
                .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
                .eraseToAnyPublisher()
            
        case .throttle:
            controlled = base
                .throttle(for: .milliseconds(1000), scheduler: RunLoop.main, latest: true)
                .eraseToAnyPublisher()
        }
        
        pipelineSubscription = controlled
            .handleEvents(receiveOutput: { [weak self] value in
                guard let self else { return }
                self.apiCallCount += 1
                let entry = CallLogEntry(
                    index: self.apiCallCount,
                    query: value,
                    mode: self.selectedMode
                )
                self.callLog.insert(entry, at: 0) // newest first
                if self.callLog.count > 30 { self.callLog.removeLast() }
            })
            .sink { _ in }
    }
    
    func resetStats() {
        apiCallCount = 0
        searchText = ""
    }
}
