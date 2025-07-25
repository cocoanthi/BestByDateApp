//
//  GroupEnteryView.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/23.
//

import SwiftUI

struct GroupEnteryView: View {
    @StateObject var viewModel: GroupEnteryViewModel
    @State var id = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                Spacer()
                Text("入室するグループの情報を以下に設定してください")
                    .padding()

                VStack(alignment: .leading, spacing: 5) {
                    Text("グループID")
                    TextField("groupID", text: $id)
                    .textFieldStyle(.roundedBorder)
                    
                    Text("パスワード")
                    TextField("password", text: $password)
                    .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal, UIScreen.main.bounds.width / 8)
                Spacer()
                
                CustomButton(action: {
                    viewModel.authorizeEntryGroup(id: id, password: password)
                }, text: "入室", width: UIScreen.main.bounds.width / 2)
                    .padding()
            }
            .navigationTitle("グループ入室")
            .navigationDestination(isPresented: $viewModel.hasGroupInfo) {
                if let info = viewModel.groupInfo {
                    BestByDateListView(vm: .init(
                        groupInfo: .init(
                            groupId: info.groupId,
                            groupName: info.groupName,
                            groupPassword: info.groupPassword
                        )
                    ))
                }
            }
            ProgressIndicator(isLoading: viewModel.isLoading)
        }
        .alert("グループの入室に失敗しました", isPresented: $viewModel.showsAlert) {}
    }
}

struct GroupEnteryView_Previews: PreviewProvider {
    static var previews: some View {
        GroupEnteryView(viewModel: GroupEnteryViewModel())
    }
}
