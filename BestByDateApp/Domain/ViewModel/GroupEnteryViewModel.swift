//
//  GroupEnteryViewModel.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Foundation

class GroupEnteryViewModel: ObservableObject {
    @Published var isLoaded = false
    @Published var groupInfo: GroupInfo?

    func authorizeEntryGroup(id: String, password: String) {
        Task {
            GroupInfoRepository.shared.fetchOne(from: .init(groupId: id, password: password)) { result in
                return DispatchQueue.main.async {
                    switch result {
                    case let .success(info):
                        print("groupInfo.fetchOne succeed!")
                        self.groupInfo = info
                        self.isLoaded = true
                    case let .failure(error):
                        print(error)
                    }
                }
            }
        }
    }
}
