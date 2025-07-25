//
//  HomeView.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: .zero) {
            NavigationStack {
                Spacer()

                NavigationLink(destination: GroupCreationView(viewModel: GroupCreationViewModel()) ) {
                    Text("グループ作成")
                }
                
                Spacer()
                
                NavigationLink(destination: GroupDeleteView(viewModel: GroupDeleteViewModel())) {
                    Text("グループ削除")
                }
                
                Spacer()

                NavigationLink(destination: GroupEnteryView(viewModel: GroupEnteryViewModel())) {
                    Text("グループ入室")
                }
                
                Spacer()
                
                NavigationLink(destination: GroupHistoryView(viewModel: GroupHistoryViewModel())) {
                    Text("入室一覧")
                }
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
