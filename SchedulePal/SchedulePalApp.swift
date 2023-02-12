//
//  SchedulePalApp.swift
//  SchedulePal
//
//  Created by Shawn Shirazi on 2/6/23.
//

import SwiftUI

@main
struct SchedulePalApp: App {
    let persistentContainer = CoreDataManager.shared.persistenceContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
