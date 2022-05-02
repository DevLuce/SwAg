//
//  DescriptionView.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/28.
//

import SwiftUI

struct DescriptionView: View {
    let item : ListItem
    @State var buttonText = "Copy to clipboard"
    private let pasteboard = UIPasteboard.general
    let code : String = "Swift Code"
    
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
                    Spacer()
                    Text(code)
                    Spacer()
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
                        if linearDataItems.count > 0 {
                            if item.name == "Queue" {
                                tempLinearData.append(linearDataItems.popFirst()!)
                            } else {
                                tempLinearData.append(linearDataItems.popLast()!)
                            }
                        }
                    }, systemName: "square.and.arrow.up.fill",
                                 backgroudColor: Color(red: 0.855, green: 0.0, blue: 0.387))
                    CustomButton(action: {
                        if linearDataItems.count < 5 {
                            if item.name == "Queue" {
                                linearDataItems.append(tempLinearData.popFirst()!)
                            } else {
                                linearDataItems.append(tempLinearData.popLast()!)
                            }
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
        pasteboard.string = code
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
