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
        if dm.configurationIsValid && dm.dockerIsRunning && dm.gitIsInstalled {
            VStack {
                Text("Koinos Node")
                    .font(.largeTitle).foregroundColor(Color.accentColor)
                Text("Node block height: \( dm.nodeBlockHeight > 0 ? String(dm.nodeBlockHeight) : "-" )")
                    .font(.subheadline).foregroundColor(Color.accentColor)
                Text("Network block height: \( dm.networkBlockHeight > 0 ? String(dm.networkBlockHeight) : "-" )")
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
                          Button(action: {dm.reloadKoinos()}) {
                              Text("Reload from preferences").frame(minWidth: 160)
                          }.disabled(dm.genericRunning || dm.nodeRunning)
                          
                          Button(action: {showAlert = true}) {
                              Text("Full data reset...").frame(minWidth: 160)
                          }.disabled(dm.genericRunning || dm.nodeRunning)
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
                .toast(isPresenting: $dm.showSpinner, duration: 0){
                    dm.spinnerToast
                }
            
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
                    dataModel.updateDockerRunStatus()
                    dataModel.updateGitInstallStatus()
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
        else if !dm.dockerIsRunning {
            VStack {
                Text("Docker Desktop not detected").multilineTextAlignment(.center).font(.largeTitle).padding(.top, 16)
                Text("This app requires Docker Desktop to be installed and running").multilineTextAlignment(.center).font(.headline).padding(.top, 1)
                Text("").fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).padding(.top, 1)
                Button(action: {
                    if let url = URL(string: "https://www.docker.com/products/docker-desktop/") {
                        NSWorkspace.shared.open(url)
                    } }) {
                        Text("Download Docker Desktop")
                    }.padding([.top, .bottom], 16)
            }.padding()
                .onReceive(timer, perform: { time in
                    dataModel.updateDockerRunStatus()
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
