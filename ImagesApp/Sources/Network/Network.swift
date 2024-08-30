//
//  Network.swift
//  ImagesApp
//
//  Created by don.vo on 8/30/24.
//

import Foundation

protocol NetworkProtocol {
    func request(
        with urlString: String,
        session: URLSession,
        completion: @escaping (Result<Data,APIError>) -> Void
    )
}

extension NetworkProtocol {
    func request(
        with urlString: String,
        completion: @escaping (Result<Data,APIError>) -> Void
    ) {
        request(
            with: urlString ,
            session: .shared,
            completion: completion
        )
    }
}

final class Network: NetworkProtocol {
    //MARK: - singleton
    private static var sharedNetworking: Network = {
        let networking = Network()
        return networking
    }()
    
    class func shared() -> Network {
        return sharedNetworking
    }
    
    //MARK: - init
    private init() {}
    
    //MARK: - request
    func request(
        with urlString: String,
        session: URLSession = .shared,
        completion: @escaping (Result<Data,APIError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.errorURL))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.errorDataNotExist))
            } else {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.errorDataNotExist))
                }
            }
        }
        task.resume()
    }
}
