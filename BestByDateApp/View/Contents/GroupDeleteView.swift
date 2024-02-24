//
//  GroupDeleteView.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/23.
//

import SwiftUI

struct GroupDeleteView: View {
    @StateObject var viewModel: GroupDeleteViewModel
    @State var id = ""
    @State var password = ""
    
    var body: some View {
        Group {
            Spacer()
            Text("削除するグループの情報を以下に設定してください")
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
                // TODO: 入力された情報で検索、あればダイアログを出して削除
                viewModel.deleteGroup(id: id, password: password)
            }, text: "削除", width: UIScreen.main.bounds.width / 2)
                .padding()
        }
        .navigationTitle("グループ削除")
    }
}

struct GroupDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDeleteView(viewModel: GroupDeleteViewModel())
    }
}
