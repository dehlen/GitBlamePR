//
//  Commit.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct Commit {
    var hash: String
    var author: String
    var authorEmail: String
    var authorDate: Date
    var committer: String
    var committerEmail: String
    var committerDate: Date
    var titleLine: String
    var fullCommitMessage: String
    var repository: GitRepository?
    var html: URL? {
        return repository?.html.appendingPathComponent("commit").appendingPathComponent(hash)
    }
}
