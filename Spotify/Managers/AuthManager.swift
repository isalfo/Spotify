//
//  AuthManager.swift
//  Spotify
//
//  Created by Gonzalo Alfonso on 15/07/2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "05e724859de74cfe9c143ba16275b3ef"
        static let clientSecret = "174120657cf944c39f04d5fe5d95b9b5"
    }
    
    private init() { }
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.google.com"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirectID=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
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
    
    private func exchangeCodeForToken(code: String, completion: @escaping ((Bool)-> Void)) {
        //GET TOKEN
    }
    
    private func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
