//
//  AuthenticationManager.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/13/21.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    
    public static let shared = AuthenticationManager()
    private let auth = Auth.auth()
    private init() {}

    // Public Methods
    public func getUserData(completion: (Result<[String], NSError>) -> Void) {
        return completion(.success(["String"]))
    }
}
