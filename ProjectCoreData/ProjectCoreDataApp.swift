//
//  ProjectCoreDataApp.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import SwiftUI

@main
struct ProjectCoreDataApp: App {
   
    @StateObject var pointVM = OrderViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(vm: MainViewModel()).environmentObject(pointVM)
        }
    }
}
