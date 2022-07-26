//
//  SettingsModel.swift
//  Spotify
//
//  Created by Gonzalo Alfonso on 25/07/2022.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
