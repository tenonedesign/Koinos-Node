//
//  DataModel.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/10/22.
//

import Foundation
import AlertToast
import SwiftUI
import secp256k1
import BigInt
import Base58Swift
import ZIPFoundation

class KoinosDataModel: ObservableObject {
    
    @AppStorage("version") var version = "0.4.1" { didSet { nodeRequiresReload = true } }
    @AppStorage("minerPrivateKey") var minerPrivateKey = "" { didSet{ nodeRequiresReload = true; updatePublicKey() } }
    @AppStorage("minerPublicKey") var minerPublicKey = "" { didSet { nodeRequiresReload = true } }
    @AppStorage("producerAddress") var producerAddress = "" { didSet { nodeRequiresReload = true } }
    @AppStorage("externalApiEndpoint") var externalApiEndpoint = "https://api.koinosblocks.com"
    
    @Published var genericRunning = false
    @Published var nodeRunning = false
    @Published var nodeRequiresReload = false
    @Published var nodeBlockHeight = 0
    @Published var networkBlockHeight = 0
    @Published var producerKoin = 0
    @Published var producerVHP = 0
    @Published var dockerIsRunning = true
    @Published var gitIsInstalled = true {
        willSet{
            if newValue == true && gitIsInstalled == false {
                nodeRequiresReload = true  // this can’t have been done without git, so need to do it now
            }
        }
    }
    let serialQueue = DispatchQueue(label: "processSerialQueue")
    var applicationCanTerminate = true
    var applicationTerminationTimeout = 30
    var containerDirectory = "\(FileManager.default.urls(for:.applicationSupportDirectory, in:.userDomainMask).first?.path ?? "")/Koinos Node/"
    
    @Published var showAlert = false
    @Published var alertToast = AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "", subTitle: nil, style: nil){
        didSet{
            showAlert = false
        }
    }
    var progress = Progress()
    var progressText = ""
    @Published var showProgressToast = false
    @Published var reloadToast = AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "Restart node to apply changes", subTitle: nil, style: AlertToast.AlertStyle.style(backgroundColor: Color("AlertBackground")))
    
    func showSuccessAlert(text: String) {
        self.alertToast = AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: text, subTitle: nil, style: AlertToast.AlertStyle.style(backgroundColor: Color("AlertBackground")))
        self.showAlert = true
    }
    func showFailureAlert(text: String) {
        self.alertToast = AlertToast(displayMode: .banner(.pop), type: .error(.red), title: text, subTitle: nil, style: AlertToast.AlertStyle.style(backgroundColor: Color("AlertBackground")))
        self.showAlert = true
    }
    func shouldShowProgress(_ should: Bool, text: String = "") {
        progress = Progress()
        progressText = text
        showProgressToast = should
    }
    func validateAddress(_ address: String) -> Bool {
        return (address.count == 34)
    }
    func validatePrivateKey(_ key: String) -> Bool {
        return (key.count == 51)
    }
    var configurationIsValid: Bool {
        validateAddress(producerAddress) && validatePrivateKey(minerPrivateKey)
    }
    
    func runProcess(scriptContent: String, terminationHandler: ((Process) -> Void)?) {
        serialQueue.async {
            // run synchronously in this queue
            let semaphore = DispatchSemaphore(value: 0)
            let process = Process()
            process.environment = ["PATH":"/usr/local/:/usr/local/bin/:usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin"]
            process.executableURL = URL(fileURLWithPath: "/bin/bash")
            process.arguments = ["-c", scriptContent]
            process.terminationHandler = { process in
                semaphore.signal()
                guard let terminationHandler = terminationHandler else { return }
                terminationHandler(process)
            }
            do {
                try process.run()
            } catch let error {
                print("error running script: \(error), script: \(scriptContent)")
            }
            _ = semaphore.wait(timeout: .now() + 3)
        }
    }
    func initNode() {
        genericRunning = true
        applicationCanTerminate = false
        let scriptPath = Bundle.main.path(forResource: "koinos-reset", ofType: "sh") ?? ""
        let scriptContent = "source '\(scriptPath)' '\(dataModel.containerDirectory)' '\(dataModel.producerAddress)' '\(dataModel.minerPrivateKey)' '\(dataModel.version)'"
        runProcess(scriptContent: scriptContent, terminationHandler: { _ in
            DispatchQueue.main.async {
                self.genericRunning = false
                self.showSuccessAlert(text: "Reset complete")
            }
            self.applicationCanTerminate = true
        })
    }
    func reloadKoinos(alert: Bool = true) {
        genericRunning = true
        applicationCanTerminate = false
        let scriptPath = Bundle.main.path(forResource: "koinos-reload", ofType: "sh") ?? ""
        let scriptContent = "source '\(scriptPath)' '\(dataModel.containerDirectory)' '\(dataModel.producerAddress)' '\(dataModel.minerPrivateKey)' '\(dataModel.version)'"
        runProcess(scriptContent: scriptContent, terminationHandler: { _ in
            DispatchQueue.main.async {
                self.genericRunning = false
                if alert { self.showSuccessAlert(text: "Reload complete") }
            }
            self.applicationCanTerminate = true
        })
    }
    func startNode() {
        if (nodeRequiresReload) {
            nodeRequiresReload = false
            reloadKoinos(alert: false)
        }
        nodeRunning = true
        let scriptContent = "cd '\(containerDirectory)koinos'; docker compose --profile all up"
        runProcess(scriptContent: scriptContent, terminationHandler: { _ in
            DispatchQueue.main.async {
                self.nodeRunning = false
            }
        })
    }
    func stopNode() {
        genericRunning = true
        applicationCanTerminate = false
        let scriptContent = "cd '\(containerDirectory)koinos'; docker compose --profile all down"
        runProcess(scriptContent: scriptContent, terminationHandler: { _ in
            DispatchQueue.main.async {
                self.genericRunning = false;
                self.nodeRunning = false
                self.showSuccessAlert(text: "Node stopped")
            }
            self.applicationCanTerminate = true
        })
    }
    func openPreferences() {
        if #available(macOS 13, *) {
            NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
        } else {
            NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        }
    }
    func updateDockerRunStatus() {
        let scriptContent = "docker info > /dev/null 2>&1"
        runProcess(scriptContent: scriptContent, terminationHandler: { process in
            DispatchQueue.main.async {
                self.dockerIsRunning = process.terminationStatus == 0
            }
        })
    }
    func updateGitInstallStatus() {
        let scriptContent = "git --version > /dev/null 2>&1"
        runProcess(scriptContent: scriptContent, terminationHandler: { process in
            DispatchQueue.main.async {
                self.gitIsInstalled = process.terminationStatus == 0
            }
        })
    }
    func dataDirectoryExists() -> Bool {
        var exists = false
        let filePath = "\(self.containerDirectory).koinos"
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            exists = true
        }
        return exists
    }
    func saveBackup() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy";
        let dateString = formatter.string(from: Date())
        let panel = NSSavePanel()
        panel.nameFieldLabel = "Save backup as:"
        panel.nameFieldStringValue = "Koinos-backup-\(dateString).zip"
        panel.canCreateDirectories = true
        panel.begin { response in
          if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
//              print(fileUrl)
              panel.orderOut(nil)
              self.showProgressToast = true
              self.shouldShowProgress(true, text: "Creating backup")
              DispatchQueue.global(qos: .background).async {
                  self.saveBackupToUrl(url: fileUrl)
              }
          }
        }
    }
    func saveBackupToUrl(url: URL) {
        // this method may be faster, but no progress indicator: https://recoursive.com/2021/02/25/create_zip_archive_using_only_foundation/
        let fm = FileManager.default
        let koinosDataUrl = URL(fileURLWithPath: "\(self.containerDirectory).koinos")
        
        // remove private key
        do {
            try fm.removeItem(atPath: "\(self.containerDirectory).koinos/block_producer/private.key")
        } catch let error {
            print("error deleting public key: \(error)")
        }

        _ = try? fm.removeItem(at: url)
        do {
            try fm.zipItem(at: koinosDataUrl, to: url, progress: progress)
        }
        catch let error {
            print("error writing zip to file: \(error)")
            DispatchQueue.main.async {
                self.shouldShowProgress(false)
                self.showFailureAlert(text: "Backup failed")
                self.reloadKoinos(alert: false) // put private key back
            }
            return
        }
        DispatchQueue.main.async {
            self.shouldShowProgress(false)
            self.showSuccessAlert(text: "Backup complete")
            self.reloadKoinos(alert: false) // put private key back
        }
    }
    func restoreFromBackup() {
        let panel = NSOpenPanel()
        panel.nameFieldLabel = "Open backup"
        panel.canCreateDirectories = true
        panel.begin { response in
          if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
              print(fileUrl)
              panel.orderOut(nil)
              self.shouldShowProgress(true, text: "Restoring from backup")
              DispatchQueue.global(qos: .background).async {
                  do {
                      let fm = FileManager.default
                      _ = try? fm.removeItem(at: URL(fileURLWithPath: "\(self.containerDirectory).koinos"))
                      try fm.unzipItem(at: fileUrl, to: URL(fileURLWithPath: self.containerDirectory), progress: self.progress)
                  }
                  catch let error {
                      print("error reading from zip file: \(error)")
                      DispatchQueue.main.async {
                          self.shouldShowProgress(false)
                          self.showFailureAlert(text: "Restore failed")
                      }
                      return
                  }
                  DispatchQueue.main.async {
                      self.shouldShowProgress(false)
                      self.showSuccessAlert(text: "Restore complete")
                      self.reloadKoinos(alert: false) // put private key back
                  }
              }
          }
        }
    }
    
    func generatePrivateKey(bitWidth: Int) -> Data {
        while true {
            let random = BigUInt.randomInteger(withMaximumWidth: bitWidth)  // uses arc4random_buf
            if random > BigUInt(1) {    // chances of this recomputing are vanishingly small
                if random < BigUInt("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141", radix: 16) ?? BigUInt(0) {
                    return random.serialize()
                }
            }
        }
    }
    func updatePublicKey() {
        
        if !validatePrivateKey(minerPrivateKey) { minerPublicKey = ""; return }
        let privateKeyBytesWithPrefix = Base58.base58CheckDecode(minerPrivateKey) ?? []
        let privateKeyBytes = privateKeyBytesWithPrefix.dropFirst(1)
        
        guard let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN)) else { return }
        // https://github.com/greymass/swift-eosio/blob/master/Sources/EOSIO/Secp256k1.swift
        let publicKeyPointer = UnsafeMutablePointer<secp256k1_pubkey>.allocate(capacity: 64)
        defer { publicKeyPointer.deallocate() }
        let keyGenResult = secp256k1_ec_pubkey_create(ctx, publicKeyPointer, [UInt8](privateKeyBytes))
        if keyGenResult == 0 { return }
        
        var compressedSize = 33
        var compressedPublicKey = Data(count: compressedSize)
        _ = compressedPublicKey.withUnsafeMutableBytes { (pointer: UnsafeMutablePointer) in
            secp256k1_ec_pubkey_serialize(ctx, pointer, &compressedSize, publicKeyPointer, UInt32(SECP256K1_EC_COMPRESSED))
        }
        
        var uncompressedSize = 65
        var uncompressedPublicKey = Data(count: uncompressedSize)
        _ = uncompressedPublicKey.withUnsafeMutableBytes { (pointer: UnsafeMutablePointer) in
            secp256k1_ec_pubkey_serialize(ctx, pointer, &uncompressedSize, publicKeyPointer, UInt32(SECP256K1_EC_UNCOMPRESSED))
        }
        
//        print("compressed public key: \(compressedPublicKey.toHexString)")
//        print("uncompressed public key: \(uncompressedPublicKey.toHexString)")
        minerPublicKey = compressedPublicKey.base64urlEncodedString()
//        print("public key: \(minerPublicKey)")
    }
    func generateKeyPair() {
        
        var privateKey = generatePrivateKey(bitWidth: 256)
        privateKey = [128] + privateKey // 0x80 is the chain id (mainnet)
//        print("private key: \(privateKey)")
//        print("private key: \(Base58.base58Encode([UInt8](privateKey)))")
//        print("private key: \(Base58.base58CheckEncode([UInt8](privateKey)))")
        minerPrivateKey = Base58.base58CheckEncode([UInt8](privateKey))
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    static func jsonEncode(_ foundationObject: Any) -> Data {
        return (try? JSONSerialization.data(withJSONObject: foundationObject)) ?? Data()
    }
    static func dictionaryFromJSON(json: Data) -> Dictionary<String, Any> {
        let json = try? JSONSerialization.jsonObject(with: json, options: [])
        if let dictionary = json as? [String: Any] {
            return dictionary
        }
        return Dictionary()
    }
    static func koinosCall(host: String, method: String, params: Any?, callback: @escaping (Data?, Error?) -> Void) {
        let object = [
            "id": 1,
            "jsonrpc": "2.0",
            "method": method,
            "params":  params ?? [String: String]()
            ] as [String : Any]
//        print(object)
        self.request(host: host, method: "POST", path: "", queryString: "", jsonRequest: jsonEncode(object), authToken: "") { (reply: Data?, error: Error?) in
            callback(reply, error)
        }
    }
    static func getBlockHeights(host: String, callback: @escaping (Int?, Error?) -> Void) {
        self.koinosCall(host: host, method: "block_store.get_highest_block", params: nil) { (reply: Data?, error: Error?) in
            if (error != nil) { callback(nil, error) }
            else {
                let dictionary = dictionaryFromJSON(json: reply!)
                let result = dictionary["result"] as? [String: NSDictionary] ?? [String:NSDictionary]()
                let topology = result["topology"] as? [String: String] ?? [String:String]()
                callback(Int(topology["height"] ?? "") ?? 0, nil)
            }
        }
    }

    
    
    
    
    func decodeVarint(varint: Data) -> UInt64 {
        var hexString = varint.toHexString
//        print(hexString)
        hexString.removeFirst(2)
//        print(hexString)
        var binaryString = String(Int(hexString, radix: 16)!, radix: 2) // convert from hex string to binary string
        while binaryString.count % 8 != 0 { // pad again
            binaryString = "0".appending(binaryString)
        }
//        print(binaryString)
        var modifiedString = ""
        for (i, _) in binaryString.enumerated() {
            if i % 8 == 0 {
                let startIndex = binaryString.index(binaryString.startIndex, offsetBy: i+1)
                let endIndex = binaryString.index(binaryString.startIndex, offsetBy: i+7)
                // switch from big to little endian here
                modifiedString = binaryString[startIndex...endIndex] + modifiedString
            }
        }
//        print(modifiedString)
        return UInt64(modifiedString, radix: 2) ?? 0
    }
    
    func getBalance(contractId: String, entryPoint: Int, address: String, callback: @escaping (Int?, Error?) -> Void) {
        let formattedAddess = Data(Base58.base58Decode(address) ?? []).dropFirst()
        let prefix = "0a1900".toDataFromHex ?? Data()
        let messageData = prefix + formattedAddess
        let message = messageData.base64urlEncodedString()
        let params = [
            "contract_id": contractId,
            "entry_point": entryPoint,
            "args": message
            ] as [String : Any]
        KoinosDataModel.koinosCall(host: externalApiEndpoint, method: "chain.read_contract", params: params) { (reply: Data?, error: Error?) in
            if (error != nil) { callback(nil, error) }
            else {
                let dictionary = KoinosDataModel.dictionaryFromJSON(json: reply!)
                let result = dictionary["result"] as? [String: String] ?? [String:String]()
                let balanceBase64 = result["result"] ?? ""
                let balanceData = Data(base64urlEncoded: balanceBase64) ?? Data()
                if balanceData.isEmpty { callback(nil, "invalid response"); return }
                callback(Int(self.decodeVarint(varint: balanceData)), nil)
            }
        }
    }
    
    
    
    static func request(host: String, method: String, path: String, queryString: String, jsonRequest: Data?, authToken: String, callback: @escaping (Data?, Error?) -> Void) {
        var destination = "\(host)\(path)/"
//        print(destination)
        if queryString.count > 0 { destination = "\(destination)?$queryString" }
        var request = URLRequest(url: URL(string: destination)!)
        request.httpMethod = method // "GET", "POST", "PATCH"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(authToken)"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonRequest
//        print(String(bytes: jsonRequest ?? Data(), encoding: .utf8))
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
//            if let data = data, let utf8Representation = String(data: data, encoding: .utf8) {
//                print("response: ", utf8Representation)
//            } else {
//                print("no readable data received in response")
//            }
            
            DispatchQueue.main.async {
                if error != nil || data == nil {
                    print("transport error")
                    callback(data, error)   // assuming error must not be nil here
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("response is not HTTPURLResponse")
                    callback(data, error)   // assuming error must not be nil here
                    return
                }
//                guard let mime = httpResponse.mimeType, mime == "application/json" else {
//                    print("Wrong MIME type: \(httpResponse.mimeType ?? "")")
//                    callback(data, "wrong mime type")
//                    return
//                }
                if (200...299).contains(httpResponse.statusCode) {
                    callback(data, nil)
                    return
                }
                else {
                    callback(data, String(httpResponse.statusCode)) // error is a string of the response code, and the response is available
                }
            }



        }
        task.resume()
    }
    
}
