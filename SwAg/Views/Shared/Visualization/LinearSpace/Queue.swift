//
//  Queue.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/05/01.
//

import SwiftUI

struct Queue: View {
    
    let item: ArraySlice<(Int, Color)>
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Divider()
                    .frame(width: proxy.size.width * 0.95, height: 3)
                    .background(.black)
                HStack(alignment: .center, spacing: proxy.size.width / 120) {
                    Spacer()
                        .frame(height: proxy.size.height / 3)
                    ForEach(item, id: \.self.0) { index, color in
                        SavingBox(
                            index: index,
                            color: color,
                            width: proxy.size.width / 5 * 0.9,
                            height: proxy.size.height / 3)
                        .transition(
                            AnyTransition.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            )
                        )
                    }
                    .animation(
                        .easeInOut
                            .speed(2)
                            .delay(0.03),
                        value: item.count)
                    Spacer()
                        .frame(height: proxy.size.height / 3)
                }
                Divider()
                    .frame(width: proxy.size.width * 0.95, height: 3)
                    .background(.black)
            }
            .position(x:proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }
}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        Queue(
            item: ArraySlice(ModelData().linearData)
        )
        .frame(height: 350)
    }
}
