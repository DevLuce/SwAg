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
            case "teal":
                return .teal
            case "act":
                return Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
            case "deact":
                return Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
            case "sel":
                return Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
            default:
                return .yellow
            }
        }
    }
}
