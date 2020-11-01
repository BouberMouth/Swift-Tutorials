//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Antoine on 31/10/2020.
//

import SwiftUI
import Firebase

@main
struct MusicPlayerApp: App {
    
    var data = OurData()
    
    init() {
        FirebaseApp.configure()
        data.loadData()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(ourData: data)
        }
    }
}
