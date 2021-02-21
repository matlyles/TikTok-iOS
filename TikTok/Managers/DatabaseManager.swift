//
//  DatabaseManager.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/13/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    public static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    private init() {}

    // Public Methods
    public func getAllUsers(completion: (Result<[String], NSError>) -> Void) {
        return completion(.success(["String"]))
    }
    
    
}
