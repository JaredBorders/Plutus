//
//  PlutusApp.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

@main
struct PlutusApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
