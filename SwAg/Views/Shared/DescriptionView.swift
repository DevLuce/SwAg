//
//  DescriptionView.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/28.
//

import SwiftUI
import CodeEditorView

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct DescriptionView: View {
    let item : ListItem
    @State var buttonText = "Copy to clipboard"
    private let pasteboard = UIPasteboard.general
    
    var sortItems : [SortItem]? {
        switch item.name {
        case "Bubble Sort":
            return ModelData().bubbleSort
        case "Selection Sort":
            return ModelData().selectionSort
        case "Insertion Sort":
            return ModelData().insertionSort
        case "Heap Sort":
            return ModelData().heapSort
        case "Merge Sort":
            return ModelData().mergeSort
        case "Quick Sort":
            return ModelData().quickSort
        default:
            return nil
        }
    }
    @State var step: Int = 0
    
    @State var linearDataItems = ArraySlice(ModelData().linearData)
    @State var tempLinearData: ArraySlice<(Int, Color)> = ArraySlice([])
    @State var binaryTree = uniqueTree
    
    @State private var text: String = """
    /* There isn't code yet */
    """
    
    @State private var position: CodeEditor.Position  = CodeEditor.Position()
    @State private var messages: Set<Located<Message>> = Set()
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    var body: some View {
        VStack{
            switch item.type {
            case "linearData":
                if item.name == "Queue" {
                    DescriptionCard(
                        Queue(item: linearDataItems)
                            .padding()
                    )
                } else {
                    DescriptionCard(
                        Stack(item: linearDataItems)
                            .padding()
                    )
                }
            case "binaryTree":
                DescriptionCard(
                    BinaryTreeView(
                        tree: binaryTree
                    )
                    .padding()
                )
            case "sort":
                DescriptionCard(
                    (sortItems != nil) ?
                    AnyView(
                        SortingGraph(
                            item: sortItems![step]
                        )
                        .padding()
                        .animation(
                            .easeInOut
                                .speed(2)
                                .delay(0.03),
                            value: step)
                    )
                    : AnyView(Text("\(item.name) Animation"))
                )
            default:
                DescriptionCard(Text("\(item.name) Animation"))
            }
            DescriptionCard(
                VStack {
                    CodeEditor(text: .constant(item.code ?? text), position: $position, messages: $messages, language: .swift)
                        .environment(\.codeEditorTheme,
                                      colorScheme == .dark ? Theme.defaultDark : Theme.defaultLight)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                    HStack {
                        Spacer()
                        Button {
                            copyToClipboard()
                        } label: {
                            HStack(spacing: 0.5) {
                                Image(systemName: "doc.on.doc.fill")
                                Text(LocalizedStringKey(buttonText))
                            }
                            .foregroundColor(.gray)
                        }
                    }
                }
                    .padding()
            )
            HStack{
                if item.type == "linearData" {
                    CustomButton(action: {
                        guard linearDataItems.count > 0 else { return }
                        
                        let items: (Int, Color) = item.name == "Queue" ? linearDataItems.popFirst()! : linearDataItems.popLast()!
                        
                        tempLinearData.append(items)
                        
                    }, systemName: "square.and.arrow.up.fill",
                                 backgroudColor: Color(red: 0.855, green: 0.0, blue: 0.387))
                    CustomButton(action: {
                        guard linearDataItems.count < 5 else { return }
                        
                        let items: (Int, Color) = item.name == "Queue" ? tempLinearData.popFirst()! : tempLinearData.popLast()!
                        
                        linearDataItems.append(items)
                        
                    }, systemName: "square.and.arrow.down.fill",
                                 backgroudColor: Color(red: 0.176, green: 0.608, blue: 0.94))
                } else if item.type == "binaryTree" {
                    CustomButton(action: {
                        withAnimation(.default) {
                            binaryTree = uniqueTree
                        }
                    }, systemName: "arrowshape.turn.up.backward.2.fill",
                                 backgroudColor: .gray)
                    CustomButton(action: {
                        withAnimation(.default) {
                            binaryTree.insert(Int.random(in: 0...100))
                        }
                    }, systemName: "square.and.arrow.down.fill",
                                 backgroudColor: Color(red: 0.176, green: 0.608, blue: 0.94))
                } else {
                    CustomButton(action: {
                        step = 0
                    }, systemName: "arrowshape.turn.up.backward.2.fill",
                                 backgroudColor: .gray)
                    .disabled(step > 0 ? false : true)
                    CustomButton(action: {
                        step -= 1
                    }, systemName: "arrowtriangle.backward.fill",
                                 backgroudColor: Color(red: 0.855, green: 0.0, blue: 0.387))
                    .disabled(step > 0 ? false : true)
                    CustomButton(action: {
                        step += 1
                    }, systemName: "arrowtriangle.forward.fill",
                                 backgroudColor: Color(red: 0.176, green: 0.608, blue: 0.94))
                    .disabled(step < (sortItems?.count ?? 1)-1 ? false : true)
                }
            }
            .padding([.leading, .bottom, .trailing])
            .navigationBarTitle(LocalizedStringKey(item.name), displayMode: .inline)
        }
    }
    
    func copyToClipboard() {
        pasteboard.string = item.code ?? text
        self.buttonText = "Copied!"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.buttonText = "Copy to clipboard"
        }
        
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(item: ModelData().algorithmList[0])
            .environmentObject(ModelData())
    }
}
