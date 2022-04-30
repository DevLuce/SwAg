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
    
    var items : [SortItem]? {
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
    
    var body: some View {
        VStack{
            DescriptionCard(
                (items != nil) ?
                AnyView(
                    SortingGraph(
                        item: items![step]
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
                .disabled(step < (items?.count ?? 1)-1 ? false : true)
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
