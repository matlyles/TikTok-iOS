//
//  StorageManager.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/13/21.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    public static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    
    private init() {}

    // Public Methods
    public func getVideoUrl(with id: String, completion: (Result<URL?, NSError>)->Void) {
        return completion(.success(URL(string: "url")))
    }
    public func getAllVideos(completion: (Result<[URL?], NSError>) -> Void) {
        return completion(.success([URL(string: "url")]))
    }
}
