//
//  Command.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/11.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct CommandError: Error, LocalizedError {
    static var unknown = CommandError(description: "Unknown error.")
    static var parse = CommandError(description: "Parse error.")

    private var description: String
    var errorDescription: String? {
        return description
    }

    init(description: String) {
        self.description = description
    }

    init(error: Error) {
        self.init(description: error.localizedDescription)
    }
}

protocol Command {
    var executableURL: URL { get }
    var arguments: [String] { get }
    var directoryURL: URL { get }

    func standardOutput() throws -> String
}

extension Command {
    func standardOutput() throws -> String {
        return try Process.run(
            executableURL: executableURL,
            arguments: arguments,
            currentDirectoryURL: directoryURL
        )
    }
}
