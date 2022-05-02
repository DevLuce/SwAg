//
//  SavingBox.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/05/01.
//

import SwiftUI

struct SavingBox: View {
    let index: Int
    let color: Color
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(color)
            .frame(width: width, height: height)
    }
}

struct SavingBox_Previews: PreviewProvider {
    static var previews: some View {
        SavingBox(
            index: 0,
            color: .blue,
            width: 150,
            height: 150
        )
    }
}
