//
//  ActivityIndicatorify.swift
//  LoveInASnap
//
//  Created by Khoa Tran on 01/12/2021.
//

import SwiftUI

struct ActivityIndicatorify: ViewModifier {
    @Binding var showLoading: Bool
    
    func body(content: Content) -> some View {
        Group {
            if showLoading {
                ZStack {
                    content
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ActivityIndicator(isAnimating: $showLoading, style: .large)
                }
            } else {
                content
            }
        }
    }
}

extension View {
    func activityIndicatorify(showLoading: Binding<Bool>) -> some View {
        self.modifier(ActivityIndicatorify(showLoading: showLoading))
    }
}
