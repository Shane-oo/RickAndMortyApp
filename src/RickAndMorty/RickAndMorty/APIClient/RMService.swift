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
    
    private let cacheManager = RMAPICacheManager()
    
    /// Privitatized constructor
    private init() {}
    
    
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: callback with data or error
    public func execute<T: Codable>(
        _ requestBuilder: RMRequestBuilder,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            
            if let cachedData = cacheManager.cachedResponse(
                for: requestBuilder.endpoint,
                url: requestBuilder.url) {
                // decode response
                do {
                    let result = try JSONDecoder().decode(type.self,
                                                          from: cachedData)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
                return
            }
            
            guard let urlRequest = self.request(from: requestBuilder) else {
                completion(.failure(RMServiceError.failedToCreateRequest))
                return
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) {
                [weak self] data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(error ?? RMServiceError.failedToGetData))
                    return
                }
                
                // decode response
                do {
                    let result = try JSONDecoder().decode(type.self, from: data)
                    self?.cacheManager.setCache(for: requestBuilder.endpoint,
                                                url: requestBuilder.url,
                                                data: data)
                    
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    
    // MARK: - Private
    
    private func request(from rmRequestBuilder: RMRequestBuilder) -> URLRequest? {
        guard let url = rmRequestBuilder.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequestBuilder.httpMethod
        
        return request
    }
}
