//
//  CreationView.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/23.
//

import SwiftUI

struct GroupCreationView: View {
    @StateObject var viewModel: GroupCreationViewModel
    @State private var groupName = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                Spacer()
                Text("以下の項目を設定してください。")
                    .padding()
                
                Text("グループ名")
                    .padding()
                VStack(alignment: .leading, spacing: 5) {
                    TextField("group_name", text: $groupName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal, UIScreen.main.bounds.width / 8)
                Text("パスワード")
                    .padding()
                VStack(alignment: .leading, spacing: 5) {
                    TextField("password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal, UIScreen.main.bounds.width / 8)
                Spacer()
                
                CustomButton(action: {
                    viewModel.registerGroup(groupName: groupName, password: password)
                }, text: "作成", width: UIScreen.main.bounds.width / 2)
                    .padding()
            }
            .navigationTitle("グループ作成")
            .navigationDestination(isPresented: $viewModel.hasGroupInfo) {
                BestByDateListView(vm: .init(groupInfo: .init(
                    groupId: viewModel.groupInfo?.groupId ?? "",
                    groupName: viewModel.groupInfo?.groupName ?? "",
                    groupPassword: viewModel.groupInfo?.groupPassword ?? ""
                )))
            }
            ProgressIndicator(isLoading: viewModel.isLoading)
        }
        .alert("グループの作成に失敗しました", isPresented: $viewModel.showsAlert) {}
    }
}

struct GroupCreationView_Previews: PreviewProvider {
    static var previews: some View {
        GroupCreationView(viewModel: GroupCreationViewModel())
    }
}
