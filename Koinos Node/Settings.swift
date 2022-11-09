//
//  Settings.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/11/22.
//


import SwiftUI
import AlertToast


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
                   if #available(macOS 12.0, *) {
                       TextField("Version", text: $dm.version, prompt: Text("e.g. 1.0.0 or latest")).textFieldStyle(RoundedBorderTextFieldStyle())
                       TextField("External API endpoint", text: $dm.externalApiEndpoint, prompt: Text("https://api.koinosblocks.com")).textFieldStyle(RoundedBorderTextFieldStyle())
                   } else {
                       TextField("Version", text: $dm.version).textFieldStyle(RoundedBorderTextFieldStyle())
                       TextField("External API endpoint", text: $dm.externalApiEndpoint).textFieldStyle(RoundedBorderTextFieldStyle())
                   }
               }
           }
           if dm.nodeRunning && dm.nodeRequiresReload {
               VStack(alignment: .center) {
                   Text("Note: restart node to apply changes").font(.headline).padding(.leading, 24).padding(.trailing, 24).padding(.top, 6).padding(.bottom, 6).overlay(
                       Capsule(style: .continuous)
                           .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 1))
                   )
               }.frame(maxWidth: .infinity).padding(.top, 18)
           }
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
                    if #available(macOS 12.0, *) {
                        TextField("Address to receive mined KOIN", text: $dm.producerAddress, prompt: Text("1JUukHhhVr5s...")).textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Private key for this miner", text: $dm.minerPrivateKey, prompt: Text("5K2gahJ27hja...")).textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        TextField("Address to receive mined KOIN", text: $dm.producerAddress).textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Private key for this miner", text: $dm.minerPrivateKey).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
            }
            Button(action: {showAlert = true}) {
                Text("Generate new private key")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Generating new keys will remove the existing key from the miner"),
                    message: Text("This can not be undone. Before continuing, consider if the existing private key controls any funds, and if you need to store the key elsewhere. Make sure to link the new key with your account containing VHP so mining will work."),
                    primaryButton: .default(Text("Regenerate miner private and public keys")) {
                        dm.generateKeyPair()
                    },
                    secondaryButton: .cancel()
                )
            }
            if dm.producerAddress.count > 0 && dm.minerPrivateKey.count > 0 {
                Text("Koinos CLI commands to link this miner with your address containing VHP:").font(.headline).padding(.top)
                
                if #available(macOS 12, *) {
                    Text("connect https://api.koinosblocks.com/\nopen \"/Users/your-username/your-koinos-wallet\" your-wallet-password\nregister pob 159myq5YUhhoVWu3wsHKHiJYKPKGUrGiyv\npob.register_public_key \(dm.producerAddress) \(dm.minerPublicKey)").textSelection(.enabled).multilineTextAlignment(.leading).lineLimit(10)
                        .fixedSize(horizontal: false, vertical: true).font(.system(.body, design: .monospaced)).padding(.bottom).padding(.top, 2)
                } else {
                    Text("connect https://api.koinosblocks.com/\nopen \"/Users/your-username/your-koinos-wallet\" your-wallet-password\nregister pob 159myq5YUhhoVWu3wsHKHiJYKPKGUrGiyv\npob.register_public_key \(dm.producerAddress) \(dm.minerPublicKey)").multilineTextAlignment(.leading).lineLimit(10)
                        .fixedSize(horizontal: false, vertical: true).font(.system(.body, design: .monospaced)).padding(.bottom).padding(.top, 2)
                }
            }
            
            if dm.nodeRunning && dm.nodeRequiresReload {
                VStack(alignment: .center) {
                    Text("Note: restart node to apply changes").font(.headline).padding(.leading, 24).padding(.trailing, 24).padding(.top, 6).padding(.bottom, 6).overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 1))
                    )
                }.frame(maxWidth: .infinity).padding(.top, 18)
            }
        }
    }
}
 
struct PrivacySettingsView: View {
    var body: some View {
        Text("Privacy Settings")
            .font(.title)
    }
}
