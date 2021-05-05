//
//  ExploreUserViewModel.swift
//  TikTok
//
//  Created by Matthew Lyles on 5/5/21.
//

import UIKit

struct ExploreUserViewModel {
    let profileImageURL: URL?
    let username: String
    let followerCount: Int
    let handler: (() -> Void)
}
