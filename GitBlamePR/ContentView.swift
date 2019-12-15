//
//  ContentView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2019/12/07.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import SwiftUI
import AppKit

struct GitBlamePRViewModel {
    var lines: [(message: String, url: URL, code: String)]
}

struct ContentView: View {
    let service = ApplicationService()

    var body: some View {
        GitBlamePRView(model: service.viewModel)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GitBlamePRView(
                model: GitBlamePRViewModel(lines: [
                    (
                        message: "PR #2020",
                        url: URL(string: "https://github.com")!,
                        code: "// hello hello hello"
                    ),
                    (
                        message: "PR #2020",
                        url: URL(string: "https://github.com")!,
                        code: "ContentView("
                    ),
                    (
                        message: "fe214",
                        url: URL(string: "https://github.com")!,
                        code: "    model: ContentViewModel(lines: ["
                    ),
                ])
            )
        }
    }
}

struct GitBlamePRView: View {
    var model: GitBlamePRViewModel
    @State private var filePath: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("Full Path", text: $filePath)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Divider()
            List {
                ForEach(0..<model.lines.count) { i in
                    HStack {
                        Text(self.model.lines[i].message)
                            .foregroundColor(.accentColor)
                            .frame(width: 100, height: nil, alignment: .leading)
                            .onTapGesture {
                                NSWorkspace.shared.open(self.model.lines[i].url)
                        }
                        Text(self.model.lines[i].code)
                            .font(Font.system(.caption, design: .monospaced))
                            .frame(width: nil, height: nil, alignment: .leading)

                    }
                }
            }
        }
    }
}
