//
//  PostComment.swift
//  TikTok
//
//  Created by Matthew Lyles on 5/2/21.
//

import Foundation

struct PostComment {
    let text: String
    let user: User
    let date: Date
    
    static func mockComments() -> [PostComment] {
        let user = User(username: "KevinFlynn", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/women/39.jpg"), id: UUID().uuidString)
        return [
            PostComment(text: "this is my first comment", user: user, date: Date().addDays(-2)),
            PostComment(text: "just another one of my comments", user: user, date: Date().addHours(-10)),
            PostComment(text: "I'm having alot of fun, just to let you know!", user: user, date: Date().addHours(-6)),
            PostComment(text: "this is my second comment of the day", user: user, date: Date().addMinutes(-20)),
            PostComment(text: "You Rock!", user: user, date: Date().addMinutes(-4)),
            PostComment(text: "I'm still having alot of fun.... that is all", user: user, date: Date().addMinutes(-0.5))
        ]
    }
}
