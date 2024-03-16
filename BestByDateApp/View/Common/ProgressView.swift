//
//  ProgressView.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/03/16.
//

import SwiftUI

struct ProgressIndicator: View {
    let isLoading: Bool

    var body: some View {
        if isLoading {
            ZStack {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
                    .tint(Color.white)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .scaleEffect(1.2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            EmptyView()
        }
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator(isLoading: true)
    }
}
