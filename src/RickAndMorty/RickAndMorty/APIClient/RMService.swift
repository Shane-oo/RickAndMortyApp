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
    ///   - completion: callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void){
        
    }
}
