//
//  CircleNode.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/05/02.
//

import SwiftUI

struct CircleNode: View {
    let index: Int
    let color: Color
    let radius: CGFloat
    let label: String?
    let fontSize: CGFloat
    
    var body: some View {
        ZStack{
            Circle()
                .fill(color)
            Text(label ?? "")
                .font(.system(size: fontSize))
                .fontWeight(.bold)
        }
        .frame(width: radius, height: radius)
    }
}

struct CircleNode_Previews: PreviewProvider {
    static var previews: some View {
        CircleNode(
            index: 0,
            color: .blue,
            radius: 150,
            label: "1",
            fontSize: 50)
    }
}
