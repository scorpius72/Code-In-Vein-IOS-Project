//
//  IOS_ProjectApp.swift
//  IOS_Project
//
//  Created by Ahsan Habib Swassow on 24/12/22.
//

import SwiftUI
import Firebase

@main
struct IOS_ProjectApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
