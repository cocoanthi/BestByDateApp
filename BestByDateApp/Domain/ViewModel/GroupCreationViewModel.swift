//
//  GroupCreationViewModel.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Foundation

class GroupCreationViewModel: ObservableObject {
    @Published var isLoaded: Bool = false

    func registerGroup() {
        isLoaded = true
    }
}
