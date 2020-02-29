//
//  ContentView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/07.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import SwiftUI
import AppKit


struct ContentView: View {
    @ObservedObject private var service: ApplicationService
    private var fullPath: String

    init() {
        self.service = ApplicationService()
        self.fullPath = ""
    }

    init(fullPath: String) {
        self.service = ApplicationService()
        self.fullPath = fullPath
        self.service.fullPath = self.fullPath
    }

    var body: some View {
        GitBlamePRView(
            model: service.viewModel,
            fullPath: fullPath,
            textOnCommit: {text in
                self.service.fullPath = text
            },
            clearOnTap: {
                self.service.clearHistory()
            }
        )
    }
}

struct GitBlamePRViewModel {
    var lines: [(message: String, url: URL, code: String, id: UUID)]
    var recent: RecentViewModel
    var error = ""
}

struct GitBlamePRView: View {
    var model: GitBlamePRViewModel
    @State var fullPath: String
    var textOnCommit: (String) -> Void
    var clearOnTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField(
                "Enter full path",
                text: $fullPath,
                onEditingChanged: {_ in },
                onCommit: {
                    self.textOnCommit(self.fullPath)
                }
            ).lineLimit(1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Divider()
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    if !model.error.isEmpty {
                        Text(model.error)
                    }
                    if !model.recent.fullPaths.isEmpty {
                        RecentView(
                            model: model.recent,
                            textOnTap: { text in
                                self.fullPath = text
                            },
                            clearOnTap: {
                                self.clearOnTap()
                            }
                        ).padding()
                    }
                    ForEach(model.lines, id: \.id) { line in
                        HStack(alignment: .top, spacing: 12) {
                            Text(line.message)
                                .font(Font.system(.caption, design: .monospaced))
                                .foregroundColor(.accentColor)
                                .frame(width: 80, height: nil, alignment: .trailing)
                                .onTapGesture {
                                    NSWorkspace.shared.open(line.url)
                            }
                            Text(line.code)
                                .font(Font.system(.caption, design: .monospaced))
                                .frame(width: nil, height: nil, alignment: .leading)
                        }
                    }
                    HStack {
                        Spacer()
                        EmptyView()
                    }
                }.padding()
            }.background(Color(NSColor.textBackgroundColor))
        }
    }
}

struct GitBlamePRView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GitBlamePRView(
                model: GitBlamePRViewModel(
                    lines: [
                        (
                            message: "PR #2020",
                            url: URL(string: "https://github.com")!,
                            code: "struct ContentView: View {",
                            id: UUID()
                        ),
                        (
                            message: "PR #2020",
                            url: URL(string: "https://github.com")!,
                            code: "",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "    var body: some View {",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "        GitBlamePRView(",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "            model: service.viewModel,",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "            textOnCommit: {text in",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "                self.service.fullPath = text",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "            }",
                            id: UUID()
                        ),
                    ],
                    recent: RecentViewModel(fullPaths: [])
                ),
                fullPath: "",
                textOnCommit: {_ in },
                clearOnTap: {}

            )

            GitBlamePRView(
                model: GitBlamePRViewModel(
                    lines: [],
                    recent: RecentViewModel(fullPaths: [
                        (value: "/Users/aoyama/Dropbox/GitBlamePR/README.md", id: UUID())

                    ])
                ),
                fullPath: "",
                textOnCommit: {_ in },
                clearOnTap: {}
            )

        }
    }
}
