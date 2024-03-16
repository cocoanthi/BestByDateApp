import SwiftUI

struct TapGestureWithEffect: ViewModifier {
    let action: () -> Void

    @State private var opacity = 1.0

    func body(content: Content) -> some View {
        content
            .opacity(self.opacity)
            .gesture(TapGesture().onEnded {
                withAnimation {
                    self.opacity = 0.3
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150)) {
                    withAnimation {
                        self.opacity = 1
                    }
                }
                self.action()
            })
    }
}
