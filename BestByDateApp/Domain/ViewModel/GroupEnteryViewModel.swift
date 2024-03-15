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
            do {
                let info = try await GroupInfoRepository.shared.fetchOne(from: .init(groupId: id, password: password))
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
