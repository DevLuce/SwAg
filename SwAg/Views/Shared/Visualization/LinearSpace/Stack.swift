//
//  Stack.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/05/02.
//

import SwiftUI

struct Stack: View {
    
    let item: ArraySlice<(Int, Color)>
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                Spacer()
                VStack(alignment: .center, spacing: proxy.size.width / 120)  {
                    Spacer()
                        .frame(width: proxy.size.width / 3 * 1.5)
                    ForEach(item.reversed(), id: \.self.0) { index, color in
                        SavingBox(
                            index: index,
                            color: color,
                            width: proxy.size.width / 3 * 1.5,
                            height: proxy.size.height / 5 * 0.85)
                        .transition(
                            AnyTransition.asymmetric(
                                insertion: .move(edge: .top),
                                removal: .move(edge: .top)
                            )
                        )
                    }
                    .animation(
                        .easeInOut
                            .speed(2)
                            .delay(0.03),
                        value: item.count)
                }
                .padding()
                .overlay(
                    Rectangle()
                        .frame(width: 4)
                        .foregroundColor(.black),
                    alignment: .leading
                )
                .overlay(
                    Rectangle()
                        .frame(width: 4)
                        .foregroundColor(.black),
                    alignment: .trailing
                )
                .overlay(
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(.black),
                    alignment: .bottom
                )
                Spacer()
            }
            .position(x:proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }
}

struct Stack_Previews: PreviewProvider {
    static var previews: some View {
        Stack(
            item: ArraySlice(ModelData().linearData)
        )
        .frame(height: 350)
    }
}
