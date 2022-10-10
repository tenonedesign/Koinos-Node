//
//  ContentView.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/9/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let executableURL = URL(fileURLWithPath: "/bin/bash")
    let containerDirectory = "\(FileManager.default.urls(for:.applicationSupportDirectory, in:.userDomainMask).first?.path ?? "")/Koinos Node/"
    let producer_address = "15a6ZZR9M52Vt5ppW4iqoQEUfuNxrasgjF"
    let miner_private_key = "5Ht9N1QNuPZ1aRMp9jh9fPM5apNjKBLCuPZL5BisCpswMSEz9Mn"
    let version = "0.4"

    @State var message = "Hello, World!"
    @State var genericRunning = false
    @State var nodeRunning = false
    
    var body: some View {
        VStack {
            Text("Koinos node")
                .font(.largeTitle)
                .padding()
            VStack {
                Button(action: {
                    let scriptPath = Bundle.main.path(forResource: "koinos-init", ofType: "sh") ?? ""
                    self.genericRunning = true
                    try! Process.run(executableURL,
                                     arguments: ["-c", "source '\(scriptPath)' '\(containerDirectory)' '\(producer_address)' '\(miner_private_key)' '\(version)'"],
                                     terminationHandler: { _ in self.genericRunning = false })
                }) {
                    Text("Full reset and init")
                }.disabled(genericRunning).padding()
                
                Button(action: {
                    self.nodeRunning = true
                    try! Process.run(executableURL,
                                     arguments: ["-c", "cd '\(containerDirectory)koinos_node/koinos';  /usr/local/bin/docker-compose-v1 --profile all up"],
                                     terminationHandler: { _ in self.nodeRunning = false })
                }) {
                    Text("Start node")
                }.disabled(nodeRunning).padding()
                
                Button(action: {
                    self.genericRunning = true
                    try! Process.run(executableURL,
                                     arguments: ["-c", "cd '\(containerDirectory)koinos_node/koinos';  /usr/local/bin/docker-compose-v1 --profile all down"],
                                     terminationHandler: { _ in self.genericRunning = false; self.nodeRunning = false })
                }) {
                    Text("Stop node")
                }.disabled(genericRunning).padding()
                
                
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
