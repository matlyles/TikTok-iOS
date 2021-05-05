//
//  ExplorePostViewModel.swift
//  TikTok
//
//  Created by Matthew Lyles on 5/5/21.
//

import UIKit

struct ExplorePostViewModel {
    let thumbnailImageView: UIImageView?
    let caption: String
    let handler: (() -> Void)
}
