//
//  GroupListRow.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/23.
//

import SwiftUI

struct CustomListRow: View {
    let title: String
    let subTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            // font一覧： https://qiita.com/wai21/items/21b381823fb12bb88268
            Text(title)
                .font(.headline)
            Text(subTitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct CustomListRow_Previews: PreviewProvider {
    static var previews: some View {
        CustomListRow(title: "title", subTitle: "subTitle")
    }
}
