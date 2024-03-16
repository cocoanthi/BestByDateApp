//
//  GroupCreationViewModel.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Foundation

class GroupCreationViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var hasGroupInfo: Bool = false
    @Published var groupInfo: GroupInfo? {
        didSet {
            hasGroupInfo = groupInfo != nil
        }
    }

    func registerGroup(groupName: String, password: String) {
        isLoading = true
        Task {
            do {
                // 終了前にインジケータを動かさないようにする
                defer {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
                
                let info = try await GroupInfoRepository.shared.insert(from: .init(
                    groupName: groupName,
                    password: password
                ))
                print("groupInfo.fetchOne succeed!")
                DispatchQueue.main.async {
                    self.groupInfo = info
                }
            } catch {
                print(error)
            }
        }
    }
}
