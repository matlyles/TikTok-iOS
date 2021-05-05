//
//  ExploreCell.swift
//  TikTok
//
//  Created by Matthew Lyles on 5/5/21.
//

import UIKit

enum ExploreCell {
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: ExplorePostViewModel)
    case hastag(viewModel: ExploreHashTagViewModel)
    case user(viewModel: ExploreUserViewModel)
}
