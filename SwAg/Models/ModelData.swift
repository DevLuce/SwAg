//
//  ModelData.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/28.
//

import Foundation

final class ModelData: ObservableObject {
    var dataStructureList: [ListItem] = load("dataStructureList.json")
    var algorithmList: [ListItem] = load("algorithmList.json")
    var bubbleSort: [SortItem] = load("bubbleSort.json")
    var selectionSort: [SortItem] = load("selectionSort.json")
    var insertionSort: [SortItem] = load("insertionSort.json")
    var heapSort: [SortItem] = load("heapSort.json")
    var mergeSort: [SortItem] = load("mergeSort.json")
    var quickSort: [SortItem] = load("quickSort.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
