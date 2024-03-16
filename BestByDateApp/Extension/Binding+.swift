import SwiftUI

extension Binding where Value: RandomAccessCollection & MutableCollection, Value.Element: Identifiable {
    struct IdentifiableItem: Identifiable {
        @Binding<Value.Element> private(set) var item: Value.Element
        let index: Value.Index
        let id: Value.Element.ID
    }

    var identifiableItems: [IdentifiableItem] {
        // Listが再描画の際に落ちる問題は、Bindingが悪さをしているせいだと考えられる。
        // そこでここでは`Binding`を生成し直すことで対処している。今のところうまく行っている。
        return self.wrappedValue.indices.map { i in
            return .init(
                item: .init {
                    self.wrappedValue[i]
                } set: {newValue in
                    self.wrappedValue[i] = newValue
                },
                index: i,
                id: self.wrappedValue[i].id
            )
        }
    }
}
