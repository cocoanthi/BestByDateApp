//
//  GroupEnteryView.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/23.
//

import SwiftUI

struct GroupEnteryView: View {
    @State var id = ""
    @State var password = ""
    // TODO: ViewModelで持つようにする
    @State var isLoaded = false
    
    var body: some View {
        Group {
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
                // TODO: 認証処理、isLoadedをtrueにする処理を入れる
                isLoaded = true
            }, text: "入室", width: UIScreen.main.bounds.width / 2)
                .padding()
        }
        .navigationTitle("グループ入室")
        .navigationDestination(isPresented: $isLoaded) {
            BestByDateListView()
        }
    }
}

struct GroupEnteryView_Previews: PreviewProvider {
    static var previews: some View {
        GroupEnteryView()
    }
}
