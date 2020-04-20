//
//  RevisionViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/18.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct RevisionViewModel {
    var commit: CommitViewModel?
    var pullRequest: PullRequestViewModel?
    var error = ""
}
