//
//  GroupEnteryViewModel.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Foundation

class GroupEnteryViewModel: ObservableObject {
    @Published var isLoaded = false
    @Published var bestByDateInfo: [BestByDateInfo]?

    func authorizeEntryGroup(id: String, password: String) {
        isLoaded = true
        BestByDateRepository.shared.fetch(from: .init(groupId: "0")) { result in
            switch result {
            case let .success(info):
                self.bestByDateInfo = info
            case let .failure(error):
                print(error)
            }
        }
    }
}
