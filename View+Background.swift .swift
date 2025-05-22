import SwiftUI

extension View {
    func lightBlueBackground() -> some View {
        self
            .background(Color("LightBlueBG").ignoresSafeArea())
    }
}

