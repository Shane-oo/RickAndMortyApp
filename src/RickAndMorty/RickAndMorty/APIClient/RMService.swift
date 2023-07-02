//
//  RMService.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import Foundation


/// Primary API Service object to get Rick and Morty data
final class RMService {
    
    /// Shared Singleton instance
    static let shared = RMService()
    
    
    /// Privitatized constructor
    private init() {}
    
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequestBuilder,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}
