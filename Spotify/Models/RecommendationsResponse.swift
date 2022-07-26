//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Gonzalo Alfonso on 26/07/2022.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
