//
//  BestByDateRepository.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Combine

final class BestByDateRepository {
    static let shared = BestByDateRepository()
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}

    func fetch(from request: GetBestByDateRequest) async throws -> [BestByDateInfo] {
        try await withCheckedThrowingContinuation { continuation in
            request.publish(completion: { (result) in
                switch result {
                case let .success(data):
                    continuation.resume(returning: data.bestByDateInfo)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }
    
    func update(from request: PutBestByDateRequest) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            request.publish(completion: { (result) in
                switch result {
                case .success:
                    continuation.resume(returning: true)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }
    
    func insert(from request: PostBestByDateRequest) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            request.publish(completion: { (result) in
                switch result {
                case .success:
                    continuation.resume(returning: true)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }
    
    func delete(from request: DeleteBestByDateRequest) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            request.publish(completion: { (result) in
                switch result {
                case .success:
                    continuation.resume(returning: true)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }
    
}
