////
////  TrialItem.swift
////  Kyokuchi
////
////  Created by L L on 25/11/2025.
////
//
// import SwiftUI
// import SwiftData
//
//
// struct Showcase: View {
//    @State var isCompleted = false
//    @State var counter = 0
////    @Query private var shukans: [Shukan]
//
//    var body: some View {
//        HStack {
//            Text("Read \(counter) pages")
//            Spacer()
//            Button {
//                isCompleted.toggle()    // toggle seems to work automatically with booleans
//            } label: {
//                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
//            }
//            }
//        .padding()
//
//        RoundedCard(title: "test")
//        ImageBackgroundCard(title: "image test", imageName: "SL2")
//        .padding()
//        .tappableSize()
//        GradientButton(text: "test string") {
//            isCompleted.toggle()
//        }
//        .padding(20)
//        Button {
//            Haptics.lightTap()
//            counter += 1
//        } label: {
//            Text("Haptic number")
//        }
//        ChatBubble(text: "bubble", isUser: true).padding()
//        NavigationStack {
//                   NavigationLink("Open Detail") {
//                       SettingsView()
//                   }
//               }
//        }
//    }
//
//
//
//
// struct NewShokun: View {
//    var body: some View{
//        Text("New Shokun")
//        TextField("Add additional Shokun", text: .constant(""))
//    }
// }
//
//
//
////func doMath(num: Int){
////    return num * 2
////}
//
// #Preview {
//    Showcase()
//        .modelContainer(for: Item.self, inMemory: true)
// }
