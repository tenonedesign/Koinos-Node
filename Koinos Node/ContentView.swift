//
//  ContentView.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/9/22.
//

import SwiftUI
import Combine
import AlertToast


struct ContentView: View {

    @ObservedObject var dm: KoinosDataModel
    
    let timer = Timer.publish(every: 5, tolerance: 0.5, on: .main, in: .common).autoconnect().merge(with: Just(Date())) // merge does the first immediate timer event
    @State private var showAlert = false
    
    var body: some View {
        if dm.configurationIsValid && dm.dockerState == .started && dm.gitIsInstalled {
            VStack {
                Text("Koinos Node")
                    .font(.largeTitle).foregroundColor(Color.accentColor)
                Text("Node block height: \( dm.nodeBlockHeight > 0 ? String(dm.nodeBlockHeight) : "-" )")
                    .font(.subheadline).foregroundColor(Color.accentColor)
                Text("Network block height: \( dm.networkBlockHeight > 0 ? String(dm.networkBlockHeight) : "-" )")
                    .font(.subheadline).foregroundColor(Color.accentColor)
                Text("Koin: \( dm.producerKoin > 0 ? String(String(dm.producerKoin).dropLast(8)) : "-" ), VHP: \( dm.producerVHP > 0 ? String(String(dm.producerVHP).dropLast(8)) : "-")")
                    .font(.subheadline).foregroundColor(Color.accentColor)
                VStack {
                    Button(action: {dm.startNode()}) {
                        Text("Start node\( dm.nodeRunning ? " (running)" : "" )").frame(minWidth: 160)
                    }.disabled(dm.nodeRunning).buttonStyle(KoinosButtonStyle())
                    
                    Button(action: {dm.stopNode()}) {
                        Text("Stop node").frame(minWidth: 160)
                    }.disabled(dm.genericRunning).buttonStyle(KoinosButtonStyle())
                    
                }.padding()
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("BackgroundColor"))
                .toolbar {
                    ToolbarItemGroup(placement: .automatic) {
                      Menu {
                          Button(action: { dm.openPreferences() }) {
                              Text("Open preferences...")
                          }
                          Button(action: {showAlert = true}) {
                              Text("Full data reset...").frame(minWidth: 160)
                          }.disabled(dm.genericRunning || dm.nodeRunning)
                          Menu("Logs") {
                              Button(action: {dm.openLog(path: "p2p/logs/p2p.log")} ) {
                                  Text("P2P").frame(minWidth: 160)
                              }
                              Button(action: {dm.openLog(path: "chain/logs/000.log")} ) {
                                  Text("Chain").frame(minWidth: 160)
                              }
                              Button(action: {dm.openLog(path: "block_store/logs/block_store.log")} ) {
                                  Text("Block Store").frame(minWidth: 160)
                              }
                              Button(action: {dm.openLog(path: "block_producer/logs/000.log")} ) {
                                  Text("Block Producer").frame(minWidth: 160)
                              }
                              Button(action: {dm.openLog(path: "jsonrpc/logs/jsonrpc.log")} ) {
                                  Text("JSON RPC").frame(minWidth: 160)
                              }
                              Button(action: {dm.openLog(path: "transaction_store/logs/transaction_store.log")} ) {
                                  Text("Transaction Store").frame(minWidth: 160)
                              }
                              Button(action: {dm.openLog(path: "mempool/logs/000.log")} ) {
                                  Text("Mempool").frame(minWidth: 160)
                              }
                              Button(action: {dm.openLog(path: "contract_meta_store/logs/contract_meta_store.log")} ) {
                                  Text("Contract Meta Store").frame(minWidth: 160)
                              }
                          }
                          Menu("Backup / restore") {
                              Button(action: {dm.saveBackup()}) {
                                  Text("Save backup...").frame(minWidth: 160)
                              }.disabled(dm.genericRunning || dm.nodeRunning)
                              Button(action: {dm.restoreFromBackup()}) {
                                  Text("Restore from backup...").frame(minWidth: 160)
                              }.disabled(dm.genericRunning || dm.nodeRunning)
                          }
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                 }
            
                .toast(isPresenting: $dm.showAlert){
                    dm.alertToast
                }
                .toast(isPresenting: $dm.showProgressToast) {
                    AlertToast(displayMode: .banner(.pop), type: .loading, title: "\(dm.progressText)\((dm.progress != nil) ? " (\(Int(floor((dm.progress?.fractionCompleted ?? 0) * 100)))%)" : "" )", subTitle: nil, style: AlertToast.AlertStyle.style(backgroundColor: Color("AlertBackground")))
                }

                .toast(isPresenting: $dm.chainFatalError, duration: 0){
                    AlertToast(displayMode: .banner(.pop), type: .error(.red), title: "Chain not responding. Restart node or restore from backup.", subTitle: nil, style: AlertToast.AlertStyle.style(backgroundColor: Color("AlertBackground")))
                }
            
                // too aggressive - shows on startup
                // could show only when node is running, but can’t combine dm.nodeRequiresReload with dm.nodeRunning here
//                .toast(isPresenting: $dm.nodeRequiresReload, duration: 0){
//                    AlertToast(displayMode: .banner(.pop), type: .regular, title: "Restart to apply changes", subTitle: nil, style: AlertToast.AlertStyle.style(backgroundColor: Color("AlertBackground")))
//                }
            
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Are you sure you want to delete all blockchain data?"),
                        message: Text("The node will need to resync, and it could take a while."),
                        primaryButton: .destructive(Text("Full reset and delete all blockchain data")) {
                            dm.initNode()
                        },
                        secondaryButton: .cancel()
                    )
                }
                .onReceive(timer, perform: { time in
                    KoinosDataModel.getBlockHeights(host: "http://localhost:8080") { (height: Int?, error: Error?) in
                        dm.nodeBlockHeight = height ?? 0
                        if dm.nodeBlockHeight > 0 {
                            dm.nodeRunning = true
                        }
                    }
                    KoinosDataModel.getBlockHeights(host: dm.externalApiEndpoint) { (height: Int?, error: Error?) in
                        dm.networkBlockHeight = height ?? 0
                    }
                    dataModel.getBalance(contractId: "1JZqj7dDrK5LzvdJgufYBJNUFo88xBoWC8", entryPoint: 1550980247, address: dm.producerAddress) { (balance: Int?, error: Error?) in
                        dm.producerVHP = balance ?? 0
                    }
                    dataModel.getBalance(contractId: "19JntSm8pSNETT9aHTwAUHC5RMoaSmgZPJ", entryPoint: 1550980247, address: dm.producerAddress) { (balance: Int?, error: Error?) in
                        dm.producerKoin = balance ?? 0
                    }
                    dataModel.updateDockerState()
                    dataModel.updateGitInstallStatus()
                    dataModel.updateChainFatalErrorStatus()
                })
        }
        else if !dm.configurationIsValid {
            VStack {
                Text("Welcome!").font(.largeTitle).padding(.top, 16)
                Text("Let’s get set up").multilineTextAlignment(.center).font(.headline).padding(.top, 1)
                Text("Set the producer address and miner private key in the preferences pane.").fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).padding(.top, 1)
                Button(action: { dm.openPreferences() }) {
                    Text("Open preferences")
                    }.padding([.top, .bottom], 16)
            }.padding()
        }
        else if dm.dockerState != .started {
            VStack {
                if (dm.dockerState == .notInstalled) {
                    Text("Docker Desktop not detected").multilineTextAlignment(.center).font(.largeTitle).padding(.top, 16)
                    Text("This app requires Docker Desktop to be installed and running").multilineTextAlignment(.center).font(.headline).padding(.top, 1)
                    Text("").fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).padding(.top, 1)
                    Button(action: {
                        if let url = URL(string: "https://www.docker.com/products/docker-desktop/") {
                            NSWorkspace.shared.open(url)
                        } }) {
                            Text("Download Docker Desktop")
                        }.padding([.top, .bottom], 16)
                }
                if (dm.dockerState == .starting || dm.dockerState == .unknown) {
                    Text("Docker is starting...").multilineTextAlignment(.center).font(.largeTitle).padding(.top, 16)
                    Text("Hang tight while Docker starts up").multilineTextAlignment(.center).font(.headline).padding(.top, 1)
                    Text("").fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).padding(.top, 1)
                }
                if (dm.dockerState == .error) {
                    Text("Error running docker").multilineTextAlignment(.center).font(.largeTitle).padding(.top, 16)
                    Text("Docker was shut down manually or has otherwise stopped").multilineTextAlignment(.center).font(.headline).padding(.top, 1)
                    Text("").fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).padding(.top, 1)
                    Button(action: { dm.dockerState = .unknown }) {
                            Text("Try running docker again")
                        }.padding([.top, .bottom], 16)
                }
            }.padding()
                .onReceive(timer, perform: { time in
                    dataModel.updateDockerState()
                })
        }
        else {
            VStack {
                Text("Git installation not detected").multilineTextAlignment(.center).font(.largeTitle).padding(.top, 16)
                Text("This app requires a Git installation").multilineTextAlignment(.center).font(.headline).padding(.top, 1)
                Text("You may already see a prompt to install.  If not, open your Terminal, type \"git\", then press Enter.  The system will walk you through the rest.").fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).padding(.top, 1)
                Button(action: {
//                    if let url = URL(string: "https://github.com/git-guides/install-git#install-git-on-mac") {
//                        NSWorkspace.shared.open(url)
//                    }
                    let url = NSURL(fileURLWithPath: "/System/Applications/Utilities/Terminal.app", isDirectory: true) as URL
                    let path = "/bin"
                    let configuration = NSWorkspace.OpenConfiguration()
                    configuration.arguments = [path]
                    NSWorkspace.shared.openApplication(at: url,
                                                       configuration: configuration,
                                                       completionHandler: nil)
                    
                }) {
                        Text("Open Terminal app")
                    }.padding([.top, .bottom], 16)
            }.padding()
                .onReceive(timer, perform: { time in
                    dataModel.updateGitInstallStatus()
                })
        }

        

    }
}

// https://stackoverflow.com/questions/59169436/swiftui-buttonstyle-how-to-check-if-button-is-disabled-or-enabled
struct KoinosButtonStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }
    struct MyButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            
            if #available(macOS 12, *) {
                configuration.label
                    .font(.headline)
                    .padding(10)
                    .foregroundColor(isEnabled ? Color(nsColor:NSColor.labelColor) : Color(nsColor:NSColor.disabledControlTextColor))
                    .background(isEnabled ? (configuration.isPressed ? Color(nsColor:NSColor.selectedControlColor) : Color(nsColor:NSColor.controlColor) ) : Color(nsColor:NSColor.separatorColor))
                    .cornerRadius(12)
            } else {    // this works but colors don’t automatically switch going from light mode to dark
                configuration.label
                    .font(.headline)
                    .padding(10)
                    .foregroundColor(isEnabled ? Color(compatNsColor:NSColor.labelColor) : Color(compatNsColor:NSColor.disabledControlTextColor))
                    .background(isEnabled ? (configuration.isPressed ? Color(compatNsColor:NSColor.selectedControlColor) : Color(compatNsColor:NSColor.controlColor) ) : Color(compatNsColor:NSColor.separatorColor))
                    .cornerRadius(12)
            }

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dm: dataModel)
    }
}
