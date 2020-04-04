//
//  ApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/14.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation

class SourceApplicationService: ObservableObject {
    @Published private(set) var viewModel: SourceViewModel
    private var historyRepository: HistoryRepository

    init(error: String="") {
        self.historyRepository = HistoryRepository()
        self.viewModel = SourceViewModel(
            lines: [],
            recent: RecentViewModel(history: self.historyRepository.findAll()),
            error: error
        )
    }

    convenience init(fullPath: FileFullPath) {
        self.init()
        fullPathDidCommit(fullPath: fullPath)
    }

    func clearHistory() {
        do {
            try historyRepository.save(history: History(inputFullPaths: []))
        } catch let e {
            viewModel.error = e.localizedDescription
        }
        viewModel.recent = RecentViewModel(fullPaths: [])
    }

    func fullPathDidCommit(fullPath: FileFullPath) {
        var remoteOut = ""
        var blamePROut = ""
        do {
            remoteOut = try Git.remote(path: fullPath)
            blamePROut = try Git.blamePR(path: fullPath)
        } catch let e {
            viewModel = SourceViewModel()
            viewModel.error = e.localizedDescription
            viewModel.recent = RecentViewModel(history: historyRepository.findAll())
            return
        }

        var history = historyRepository.findAll()
        history.addInputFullPath(fullPath.rawValue)
        do {
            try historyRepository.save(history: history)
        } catch let e {
            viewModel.error = e.localizedDescription
            return
        }
        guard let source = Source(gitRemoteStandardOutput: remoteOut, gitBlamePRStandardOutput: blamePROut) else {
            viewModel.error = "Unknown error."
            return
        }
        viewModel = SourceViewModel(source: source)
    }

    func fullPathDidCommit(fullPathTextFieldValue: String) {
        guard let fullPath = FileFullPath(rawValue: fullPathTextFieldValue) else {
            viewModel = SourceViewModel()
            viewModel.recent = RecentViewModel(history: historyRepository.findAll())
            return
        }
        fullPathDidCommit(fullPath: fullPath)
    }
}
