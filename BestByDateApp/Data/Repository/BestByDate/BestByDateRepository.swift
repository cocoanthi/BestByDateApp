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
    
    func register() {
        // TODO: 登録処理
    }

    func fetch(
        from request: GetBestByDateRequest,
        completion: @escaping (Result<[BestByDateInfo], ApiRequestError>) -> Void
    ) {
        request.publish(completion: { (result) in
            switch result {
            case let .success(data):
                return completion(.success(data.bestByDateInfo))
            case let .failure(error):
                return completion(.failure(error))
            }
        })
    }
    
    func update() {
        // TODO: 更新処理
    }
    
    func delete() {
        // TODO: 削除処理
    }
    
}
