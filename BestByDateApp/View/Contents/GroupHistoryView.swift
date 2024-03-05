//
//  GroupHistoryView.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/23.
//

import SwiftUI

struct GroupHistoryView: View {
    @StateObject var viewModel: GroupHistoryViewModel
    
    var body: some View {
        NavigationStack {
            List {
                // TODO: これまでに入室したグループをUserDefaultで保持しリスト表示する
                NavigationLink(destination: {
                    BestByDateListView()
                } ) {
                    CustomListRow(title: "グループA", subTitle: "groupID: 1234")
                }
                NavigationLink(destination: {
                    BestByDateListView()
                } ) {
                    CustomListRow(title: "グループB", subTitle: "groupID: 5678")
                }
                NavigationLink(destination: {
                    BestByDateListView()
                } ) {
                    CustomListRow(title: "グループC", subTitle: "groupID: 91011")
                }
            }
        }
        .navigationTitle("入室一覧")
        .onAppear {
            viewModel.fetchGroupHistory()
        }
    }
}

struct GroupHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GroupHistoryView(viewModel: GroupHistoryViewModel())
    }
}
