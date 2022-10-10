//
//  Koinos_NodeApp.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/10/22.
//

import SwiftUI

@main
struct Koinos_NodeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
