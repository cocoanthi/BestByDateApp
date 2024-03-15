//
//  GroupCreationViewModel.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Foundation

class GroupCreationViewModel: ObservableObject {
    @Published var isLoaded: Bool = false
    @Published var groupInfo: GroupInfo?

    func registerGroup(groupName: String, password: String) {
        Task {
            do {
                let info = try await GroupInfoRepository.shared.insert(from: .init(
                    groupName: groupName,
                    password: password
                ))
                print("groupInfo.fetchOne succeed!")
                DispatchQueue.main.async {
                    self.groupInfo = info
                    self.isLoaded = true
                }
            } catch {
                print(error)
            }
        }
    }
}
