//
//  PullRequestView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/03.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PullRequestView: View {
    var model: PullRequestViewModel

    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleView(title: "Pull Request")
            VStack(alignment: .leading, spacing: 6) {
                VStack(alignment: .leading) {
                    Text(model.title + " - " + model.number )
                            .fontWeight(.bold)
                    HStack(alignment: .center) {
                        KFImage(model.userAvatarURL)
                            .cancelOnDisappear(true)
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 24, height: 24)
                            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        VStack (alignment: .leading) {
                            Text(model.user)
                            Text(model.mergedAt).foregroundColor(.secondary)
                                .font(.system(size: 11))
                        }.padding(.top, -2)
                        Spacer()
                    }
                    Text(model.body)

                }
                VStack(alignment: .leading) {
                    HStack {
                        Text(model.conversationCount).fontWeight(.bold)
                        Text("Conversation").foregroundColor(.secondary).font(.caption)
                    }
                    HStack {
                        Text(model.commitsCount).fontWeight(.bold)
                        Text("Commits").foregroundColor(.secondary).font(.caption)
                    }
                    HStack {
                        Text(model.changedFiles).fontWeight(.bold)
                        Text("File changed").foregroundColor(.secondary).font(.caption)
                    }
                    HStack {
                        Text(model.additionsCount).foregroundColor(.green)
                        Text(model.deletionsCount).foregroundColor(.red)
                    }
                }
                HStack{
                    Spacer()
                }
                Spacer()
            }
            .padding(.init(top: 2, leading: 6, bottom: 6, trailing: 6))
        }
        .background(Color(.windowBackgroundColor))
        .padding(2)
    }
}

struct PullRequestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PullRequestView(model:
                PullRequestViewModel(
                    htmlURL: URL(string: "https://example.com")!,
                    number: "#17",
                    title: "Fix git blame pr command failure when not commited",
                    body: "GitBlamePR.app bundles Xcode Source Editor Extension.Files opened in Xcode can be easily opened in GitBlamePR.app.I recommend that you set a key binding for this function.",
                    user: "maoyama",
                    userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                    mergedAt: "8 days ago",
                    conversationCount: "10",
                    commitsCount: "7",
                    changedFiles: "8",
                    additionsCount: "+283",
                    deletionsCount: "-130"
                )
            )
                .frame(width: 200)
                .environment(\.colorScheme, .light)

            PullRequestView(model:
                PullRequestViewModel(
                    htmlURL: URL(string: "https://example.com")!,
                    number: "#17",
                    title: "Fix git blame pr command failure when not commited",
                    body: "GitBlamePR.app bundles Xcode Source Editor Extension.Files opened in Xcode can be easily opened in GitBlamePR.app.I recommend that you set a key binding for this function.",
                    user: "maoyama",
                    userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                    mergedAt: "8 days ago",
                    conversationCount: "10",
                    commitsCount: "7",
                    changedFiles: "8",
                    additionsCount: "+283",
                    deletionsCount: "-130"
                )
            ).frame(width: 200)
            .environment(\.colorScheme, .dark)

            PullRequestView(model:
                PullRequestViewModel(
                    htmlURL: URL(string: "https://example.com")!,
                    number: "#17",
                    title: "Fix git blame pr command failure when not commited",
                    body: "",
                    user: "maoyama",
                    userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                    mergedAt: "2020/04/20",
                    conversationCount: "10",
                    commitsCount: "7",
                    changedFiles: "8",
                    additionsCount: "+283",
                    deletionsCount: "-130"
                )
            ).frame(width: 200)
            .environment(\.colorScheme, .dark)

        }
    }
}
