//
//  SwAgApp.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/27.
//

import SwiftUI

@main
struct SwAgApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
