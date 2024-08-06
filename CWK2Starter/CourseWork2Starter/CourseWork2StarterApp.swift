//
//  CourseWork2StarterApp.swift
//  CourseWork2Starter
//
//  Created by AnastasiiaMazur
//

import SwiftUI

@main
struct CourseWork2StarterApp: App {
    @StateObject var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
