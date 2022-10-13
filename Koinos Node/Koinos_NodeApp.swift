//
//  Koinos_NodeApp.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/10/22.
//

import SwiftUI

let dataModel = KoinosDataModel.init()

@main
struct Koinos_NodeApp: App {
    
    init() {
        if (!dataModel.dataDirectoryExists()) {
            print("Initializing and downloading Koinos")
            dataModel.initNode()
            dataModel.reloadKoinos()
        }
        dataModel.updateDockerRunStatus()
        dataModel.updateGitInstallStatus()
        dataModel.updatePublicKey()
    }
    
    @NSApplicationDelegateAdaptor(KoinosAppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(dm: dataModel).frame(width: 340, height: 320)
        }
        Settings {
            SettingsView(dm: dataModel)
        }
    }
}
