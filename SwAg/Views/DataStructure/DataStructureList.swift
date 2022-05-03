//
//  DataStructureList.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/27.
//

import SwiftUI

struct DataStructureList: View {
    
    var body: some View {
        List(ModelData().dataStructureList, children: \.children) { item in
            if item.children == nil {
                NavigationLink {
                    DescriptionView(item: item)
                } label: {
                    Text(LocalizedStringKey(item.description))
                }

            } else {
                Text(LocalizedStringKey(item.description))
            }
        }
        .listStyle(.inset)
    }
}

struct DataStructureList_Previews: PreviewProvider {
    static var previews: some View {
        DataStructureList()
            .environment(\.locale, .init(identifier: "ko"))
    }
}
