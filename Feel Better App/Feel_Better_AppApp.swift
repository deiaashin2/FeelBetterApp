//
//  Feel_Better_AppApp.swift
//  Feel Better App
//
//  Created by Sadia Khan on 11/19/24.
//

import SwiftUI

@main
struct Feel_Better_AppApp: App {
    let persistenceController = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
