//
//  SortingGraph.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/30.
//

import SwiftUI

struct SortingGraph: View {
    
    let item: SortItem
    
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                ForEach(Array(zip(item.idxList, item.uiColorList)), id: \.self.0) { index, color in
                    SortingBar(
                        color: color,
                        height: proxy.size.height / CGFloat(item.idxList.count) * CGFloat(index),
                        num: index,
                        fontSize: proxy.size.width / CGFloat(item.idxList.count) * 0.4)
                }
            }
        }
    }
}

struct SortingGraph_Previews: PreviewProvider {
    static var previews: some View {
        SortingGraph(
            item: ModelData().bubbleSort[0]
        )
        .frame(height: 350)
    }
}
