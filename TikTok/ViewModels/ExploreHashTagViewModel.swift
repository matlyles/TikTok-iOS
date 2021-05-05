//
//  ExploreHashTagViewModel.swift
//  TikTok
//
//  Created by Matthew Lyles on 5/5/21.
//

import UIKit

struct ExploreHashTagViewModel {
    let icon: UIImageView?
    let text: String
    let count: Int // number of posts that use this tag
    let handler: (() -> Void)
}

