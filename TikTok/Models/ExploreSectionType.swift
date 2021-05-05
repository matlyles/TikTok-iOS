//
//  ExploreSectionType.swift
//  TikTok
//
//  Created by Matthew Lyles on 5/5/21.
//

import UIKit

enum ExploreSectionType {
    case banners, trendingPosts, users, popularHashTags, recommended, popular, new
    
    var title: String {
        switch self {
        case .banners:
            return "Banners"
        case .trendingPosts:
            return "Trending Videos"
        case .users:
            return "Popular Creators"
        case .popularHashTags:
            return  "HashTags"
        case .recommended:
            return "Recommended"
        case .popular:
            return "Popular"
        case .new:
            return "New!"
        }
    }
}
