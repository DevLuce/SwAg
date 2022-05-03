//
//  ContentView.swift
//  DiagramsSample
//
//  Created by Chris Eidhof on 16.12.19.
//  Copyright © 2019 objc.io. All rights reserved.
//

import SwiftUI

let binaryTree = Tree<Int>(50, children: [
    Tree(17, children: [
        Tree(12),
        Tree(23)
    ]),
    Tree(72, children: [
        Tree(54),
        Tree(85)
    ])
])

let uniqueTree = binaryTree.map(Unique.init)

struct RoundedCircleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .background(Circle().stroke())
            .background(Circle().fill(Color.white))
            .padding(10)
    }
}

extension Tree where A == Unique<Int> {
    mutating func insert(_ number: Int) {
        if number < value.value {
            if children.count > 0 {
                children[0].insert(number)
            } else {
                children.append(Tree(Unique(number)))
            }
        } else {
            if children.count == 2 {
                children[1].insert(number)
            } else if children.count == 1 && children[0].value.value > number {
                children[0].insert(number)
            } else {
                children.append(Tree(Unique(number)))
            }
        }
    }
}

struct BinaryTreeView: View {
    var tree : Tree<Unique<Int>>
    
    var body: some View {
        GeometryReader { proxy in
            Diagram(tree: tree, node: { value in
                Text("\(value.value)")
                    .modifier(RoundedCircleStyle())
            })
            .frame(width: proxy.size.width, height: proxy.size.height)
            .position(x: proxy.size.width/2, y: proxy.size.height/2)
        }
    }
}


struct BinaryTreeView_Previews: PreviewProvider {
    static var previews: some View {
        BinaryTreeView(
            tree: uniqueTree
        )
    }
}
