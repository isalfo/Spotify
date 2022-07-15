//
//  AuthManager.swift
//  Spotify
//
//  Created by Gonzalo Alfonso on 15/07/2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() { }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldReturnToken: Bool {
        return false
    }
}