//
//  BestByDateAppApp.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2023/06/30.
//

import SwiftUI

@main
struct BestByDateAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
