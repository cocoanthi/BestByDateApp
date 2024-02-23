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

                // TODO: グループ作成画面に遷移
                NavigationLink(destination: {}) {
                    Text("グループ作成")
                }
                
                Spacer()
                
                // TODO: グループ削除画面に遷移
                NavigationLink(destination: {}) {
                    Text("グループ削除")
                }
                
                Spacer()

                // TODO: グループ入室画面に遷移
                NavigationLink(destination: {}) {
                    Text("グループ入室")
                }
                
                Spacer()
                
                // TODO: 履歴画面に遷移
                NavigationLink(destination: {}) {
                    Text("履歴")
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
