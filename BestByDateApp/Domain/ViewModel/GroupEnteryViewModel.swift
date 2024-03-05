//
//  GroupEnteryViewModel.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/24.
//

import Foundation

class GroupEnteryViewModel: ObservableObject {
    @Published var isLoaded = false
    
    func authorizeEntryGroup(id: String, password: String) {
        isLoaded = true
    }
}
