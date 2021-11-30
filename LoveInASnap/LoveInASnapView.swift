//
//  LoveInASnapView.swift
//  LoveInASnap
//
//  Created by Khoa Tran on 28/11/2021.
//

import SwiftUI

struct LoveInASnapView: View {
    @State private var extractedText: String = ""
    
    var body: some View {
        ZStack() {
            Color(rgb: 0x9A223C)
                .ignoresSafeArea()
            VStack() {
                Text("Snap/upload a clear picture of your poem then edit below. Tap outside of the text box once your sweet nothings are complete.")
                    .font(AppConstants.font1(withSize: 22))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                    .padding([.leading, .bottom, .trailing], 20)
                ScrollView {
                    Text(extractedText)
                        .font(AppConstants.font2(withSize: 16))
                        //                        .textSelection(.enabled)
                        .padding()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 300, maxHeight: 400, alignment: .topLeading)
                .background(Color.white)
                .padding(.horizontal, 25.0)
                
                Button("Snap/Upload Image") {
                    
                }
                .font(AppConstants.font1(withSize: 22))
                .foregroundColor(Color(rgb: 0x94BEFF))
                Spacer()
            }
        }
        .background(Color.red)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    struct AppConstants {
        static func font1(withSize size: CGFloat) -> Font {
            Font.custom("Bradley Hand Bold", size: size)
        }
        static func font2(withSize size: CGFloat) -> Font {
            Font.custom("Noteworthy", size: size)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoveInASnapView()
    }
}

extension Color {
    init(rgb: Int, opacity: Double = 1) {
        self.init(
            red: Double((rgb >> 16) & 0xFF)/255,
            green: Double((rgb >> 8) & 0xFF)/255,
            blue: Double(rgb & 0xFF)/255,
            opacity: opacity
        )
    }
}
