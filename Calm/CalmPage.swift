import SwiftUI

struct CalmPage: View {
    let calmOptions: [(title: String, destination: () -> AnyView)] = [
        ("Meditation", { AnyView(MeditationView()) }),
        ("Gentle Sound", { AnyView(NewGentleSoundView()) }),
        ("Yoga", { AnyView(YogaView()) }),
        ("Breathing", { AnyView(BreathingView()) })
    ]

    @State private var currentIndex = 0

    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midX = proxy.frame(in: .global).midX
        let screenCenter = UIScreen.main.bounds.width / 2
        let distance = abs(screenCenter - midX)
        let maxDistance = screenCenter
        return max(0.9, 1 - (distance / maxDistance) * 0.1)
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemTeal).ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("Calm")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    TabView(selection: $currentIndex) {
                        ForEach(0..<calmOptions.count, id: \.self) { index in
                            GeometryReader { geo in
                                let scale = getScale(proxy: geo)

                                NavigationLink(destination: calmOptions[index].destination()) {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.white.opacity(0.2))
                                        .frame(width: 360, height: 500)
                                        .scaleEffect(scale)
                                        .overlay(
                                            Text(calmOptions[index].title)
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .animation(.easeInOut(duration: 0.2), value: scale)
                            }
                            .padding(.horizontal, 20)
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 500)

                    HStack(spacing: 10) {
                        ForEach(0..<calmOptions.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentIndex ? Color.white : Color.white.opacity(0.4))
                                .frame(width: 10, height: 10)
                        }
                    }
                }
                .padding(.top, 60)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
   CalmPage()
}
