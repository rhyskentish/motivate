//
//  motivateApp.swift
//  motivate
//
//  Created by Rhys Kentish on 26/10/2020.
//

import SwiftUI
let store = Store(reducer: reducer)
@main
struct motivateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
