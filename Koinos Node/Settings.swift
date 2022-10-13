//
//  Settings.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/11/22.
//


import SwiftUI


struct SettingsView: View {
    
    @ObservedObject var dm: KoinosDataModel
    
    var body: some View {
        TabView {
            NodeSettingsView(dm: dm)
                .tabItem {
                    Label("Node", systemImage: "wrench.and.screwdriver")
                }
            MinerSettingsView(dm: dm)
                .tabItem {
                    Label("Miner", systemImage: "server.rack")
                }
        }
        .frame(width: 650).padding()
    }
}


struct NodeSettingsView: View {
   @ObservedObject var dm: KoinosDataModel
   var body: some View {
       VStack(alignment: .leading) {
           Text("Node settings")
               .font(.headline).padding(.top)
           Form {
               Section(header: Text("")) {
                   TextField("Version", text: $dm.version)
                   TextField("External API endpoint", text: $dm.externalApiEndpoint)
               }
           }
           Text("Use the 'Reload from preferences' menu item after any changes").padding(.top, 24)
       }
   }
}

struct MinerSettingsView: View {
    @ObservedObject var dm: KoinosDataModel
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Miner settings")
                .font(.headline).padding(.top)
            Form {
                Section(header: Text("")) {
                    TextField("Address to receive mined KOIN", text: $dm.producerAddress)
                    TextField("Private key for this miner", text: $dm.minerPrivateKey)
                }
            }
            Button(action: {showAlert = true}) {
                Text("Generate new key pair")
            }.padding(.top, 24)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Generating new keys will remove the existing key from the miner"),
                        message: Text("This can not be undone. Before continuing, consider if the existing private key controls any funds, and if you need to store the key elsewhere"),
                        primaryButton: .default(Text("Regenerate miner private and public keys")) {
                            dm.generateKeyPair()
                        },
                        secondaryButton: .cancel()
                    )
                }
            
            if #available(macOS 12, *) {
                Text("Miner public key: \(dm.minerPublicKey)").textSelection(.enabled)
            } else {
                Text("Miner public key: \(dm.minerPublicKey)")
            }
            Text("Use the 'Reload from preferences' menu item after any changes").padding(.top, 12)
        }
    }
}
 
struct PrivacySettingsView: View {
    var body: some View {
        Text("Privacy Settings")
            .font(.title)
    }
}
