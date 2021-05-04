//
//  PostModel.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/21/21.
//

import Foundation

struct PostModel {
    let identifier: String
    let user = User(username: "Frank Black",
                    profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/58.jpg"),
                    id: UUID().uuidString
    )
    var isLikedByCurrentUser = false
    
    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            posts.append(PostModel(identifier: UUID().uuidString))
        }
        return posts
    }
}

