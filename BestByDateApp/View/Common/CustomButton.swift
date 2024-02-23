//
//  CustomButton.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/02/23.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let text: String
    let textSize: CGFloat
    let weight: Font.Weight
    let width: CGFloat?
    let height: CGFloat?
    let foregroundColor: Color
    
    init(
        action: @escaping () -> Void,
        text: String,
        textSize: CGFloat = 20,
        weight: Font.Weight = .medium,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        foregroundColor: Color = .black
    ) {
        self.action = action
        self.text = text
        self.textSize = textSize
        self.weight = weight
        self.width = width
        self.height = height
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(text)
                .font(.system(size: textSize, weight: weight, design: .default))
                .frame(width: width, height: height)
                .foregroundColor(foregroundColor)
        }
        .buttonStyle(.bordered)
        
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {}, text: "hogehoge")
    }
}
