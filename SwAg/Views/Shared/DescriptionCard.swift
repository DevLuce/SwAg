//
//  DescriptionCard.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/28.
//

import SwiftUI

struct DescriptionCard<Content: View>: View {
    let content: Content
    
    init(_ content : Content) {
        self.content = content
    }
    
    var body: some View {
        content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("PrimaryColor"), lineWidth: 4)
        )
        .padding(.horizontal)
    }
}

struct DescriptionCard_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionCard(Text("hello"))
    }
}
