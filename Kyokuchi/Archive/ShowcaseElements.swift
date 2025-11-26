////
////  ShowcaseElements.swift
////  Kyokuchi
////
////  Created by L L on 25/11/2025.
////
//
// import SwiftUI
//
//
//// Cards & buttons ----------------
//
// struct RoundedCard: View {
//    var title: String
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Text(title)
//                .font(.headline)
//            Text("Description text")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//        }
//        .padding()
//        .background(.ultraThinMaterial)
//        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
//        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
//    }
// }
//
// struct ImageBackgroundCard: View {
//    var title: String
//    var imageName: String
//
//    var body: some View {
//        ZStack(alignment: .bottomLeading) {
//            Image(imageName)
//                .resizable()
//                .scaledToFill()
//                .overlay(Color.black.opacity(0.25))
//
//            Text(title)
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
////                .padding()
//                .position(x: 80, y: 100)    // QQ: how to center this the text ?
//        }
//        .frame(height: 100)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(radius: 5)
//    }
// }
//
//
// struct GradientButton: View {
//    var text: String
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            Text(text)
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(
//                    LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
//                )
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//        }
//    }
// }
//
//// Effects ----------------
//
// struct TapAnimationModifier: ViewModifier {
//    @State private var pressed = false
//
//    func body(content: Content) -> some View {
//        content
//            .scaleEffect(pressed ? 0.95 : 1.0)
//            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: pressed)
//            .onLongPressGesture(minimumDuration: 0, pressing: { isPressing in
//                pressed = isPressing
//            }, perform: {})
//    }
// }
//
//// Creating modifier to be applied like: .tappable()
// extension View {
//    func tappableSize() -> some View {
//        self.modifier(TapAnimationModifier())
//    }
// }
//
//// --- Currently not working ---
//
////struct Shimmer: ViewModifier {
////    @State private var move = false
////
////    func body(content: Content) -> some View {
////        content
////            .overlay(
////                Rectangle()
////                    .fill(
////                        LinearGradient(colors: [.clear, .white.opacity(0.2), .clear],
////                        startPoint: .top, endPoint: .bottom)
////                    )
////                    .rotationEffect(.degrees(70))
////                    .offset(x: move ? 300 : -300)
////            )
////            .onAppear {
////                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
////                    move = true
////                }
////            }
////    }
////}
////
////extension View {
////    func shimmer() -> some View {
////        modifier(Shimmer())
////    }
////}
//
//
// struct ChatBubble: View {
//    var text: String
//    var isUser: Bool
//
//    var body: some View {
//        HStack {
//            if isUser { Spacer() }
//            Text(text)
//                .padding()
//                .background(isUser ? Color.blue : Color.gray.opacity(0.3))
//                .foregroundColor(isUser ? .white : .primary)
//                .clipShape(RoundedRectangle(cornerRadius: 16))
//                .frame(maxWidth: 280, alignment: isUser ? .trailing : .leading)
//            if !isUser { Spacer() }
//        }
//        .padding(isUser ? .leading : .trailing, 40)
//        .padding(.vertical, 4)
//    }
// }
