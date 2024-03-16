//
//  GroupEnteryViewModel.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Foundation

class GroupEnteryViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var hasGroupInfo: Bool = false
    @Published var showsAlert: Bool = false

    @Published var groupInfo: GroupInfo? {
        didSet {
            hasGroupInfo = groupInfo != nil
        }
    }

    
    func authorizeEntryGroup(id: String, password: String) {
        isLoading = true
        Task {
            do {
                // 終了前にインジケータを動かさないようにする
                defer {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.showsAlert = self.groupInfo == nil
                    }
                }
                
                let info = try await GroupInfoRepository.shared.fetchOne(from: .init(groupId: id, password: password))
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
