//
//  CreationView.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/23.
//

import SwiftUI

struct GroupCreationView: View {
    @State var password = ""
    // TODO: ViewModelで持つようにする
    @State var isLoaded = false
    
    var body: some View {
        Group {
            Spacer()
            Text("作成するグループに入室するためのパスワードを設定してください。")
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("password", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal, UIScreen.main.bounds.width / 8)
            Spacer()
            
            CustomButton(action: {
                // TODO: 作成処理、isLoadedをtrueにする処理を入れる
                isLoaded = true
            }, text: "作成", width: UIScreen.main.bounds.width / 2)
                .padding()
        }
        .navigationTitle("グループ作成")
        .navigationDestination(isPresented: $isLoaded) {
            BestByDateListView()
        }
    }
}

struct GroupCreationView_Previews: PreviewProvider {
    static var previews: some View {
        GroupCreationView()
    }
}
