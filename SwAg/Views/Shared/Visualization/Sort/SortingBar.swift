//
//  SortingBar.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/30.
//

import SwiftUI

struct SortingBar: View {
    let color: Color
    let height: CGFloat
    let num: Int
    let fontSize: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
            VStack {
                Spacer()
                Text(String(num))
                    .font(.system(size: fontSize))
                    .fontWeight(.bold)
                    .padding(.bottom, 1)
            }
        }
        .frame(height: height)
    }
}

struct SortingBar_Previews: PreviewProvider {
    static var previews: some View {
        SortingBar(
            color: .blue,
            height: 150,
            num: 1,
            fontSize: 25)
    }
}
