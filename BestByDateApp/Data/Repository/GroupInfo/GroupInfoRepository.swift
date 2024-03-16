//
//  BestByDateRepository.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Combine

final class GroupInfoRepository {
    static let shared = GroupInfoRepository()
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}

    func fetchOne(from request: GetOneItemGroupInfoRequest) async throws -> GroupInfo {
        try await withCheckedThrowingContinuation { continuation in
            request.publish(completion: { (result) in
                switch result {
                case let .success(data):
                    continuation.resume(returning: data.groupInfo)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }
    
    func insert(from request: PutGroupInfoRequest) async throws -> GroupInfo {
        try await withCheckedThrowingContinuation { continuation in
            request.publish(completion: { (result) in
                switch result {
                case let .success(info):
                    continuation.resume(returning: info.groupInfo)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }
    
    func delete() {
        // TODO: 削除処理
    }
    
}
