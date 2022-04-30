//
//  ListItem.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/28.
//

import Foundation

struct ListItem: Hashable, Decodable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    var name: String
    var type: String
    var children: [ListItem]? = nil
    var description: String {
        switch children {
        case nil:
            return "📄 \(name)"
        case .some(let children):
            return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
        }
    }
}
