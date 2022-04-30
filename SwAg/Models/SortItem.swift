//
//  SortItem.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/30.
//

import Foundation
import SwiftUI

struct SortItem: Hashable, Decodable, Identifiable {
    var id: Self { self }
    var idxList: [Int]
    var colorList: [String]
    var uiColorList: [Color] {
        return colorList.map { color in
            switch color {
            case "blue":
                return .blue
            case "gray":
                return .gray
            case "purple":
                return .purple
            case "indigo":
                return .indigo
            case "brown":
                return .brown
            case "green":
                return .green
            case "red":
                return .red
            default:
                return .yellow
            }
        }
    }
}
