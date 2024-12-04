//
//  CircleProgressView.swift
//  FeelBetterApp
//
//  Created by Andreia Shin on 30/10/24.
//

import SwiftUI

struct CircleProgressView: View {
    @Binding var progress: Int
    var color: Color
    var goal: Int
    private let width: CGFloat = 20
    var body: some View {
        ZStack{
            Circle()
                .stroke(color.opacity(0.3), lineWidth:width)
            Circle()
                .trim(from:0, to: CGFloat(progress)/CGFloat(goal))
                .stroke(color, style: StrokeStyle(lineWidth: width, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .shadow(radius: 5)
            
        }
        .padding()
    }
}

#Preview {
    CircleProgressView(progress: .constant(100), color: .red, goal: 200)
}