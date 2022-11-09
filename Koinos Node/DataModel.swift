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
import SwiftProtobuf

enum DockerStates {
    case unknown
    case notInstalled
    case starting
    case started
    case error
}

class KoinosDataModel: ObservableObject {
    
    @AppStorage("version") var version = "1.0.0" { didSet { nodeRequiresReload = true } }
    @AppStorage("minerPrivateKey") var minerPrivateKey = "" { didSet{ nodeRequiresReload = true; updatePublicKey() } }
    @AppStorage("minerPublicKey") var minerPublicKey = "" { didSet { nodeRequiresReload = true } }
    @AppStorage("producerAddress") var producerAddress = "" { didSet { nodeRequiresReload = true } }
    @AppStorage("externalApiEndpoint") var externalApiEndpoint = "https://api.koinosblocks.com"
    
    @Published var genericRunning = false
    @Published var nodeRunning = false
    @Published var nodeRequiresReload = false
    @Published var nodeBlockHeight = 0
    @Published var networkBlockHeight = 0
    @Published var chainFatalError = false
    @Published var producerKoin = 0
    @Published var producerVHP = 0
    @Published var dockerState: DockerStates = .unknown
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
    var progress: Progress? = Progress()
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
    func shouldShowProgress(_ should: Bool, text: String = "", showPercent: Bool = true) {
        progress = showPercent ? Progress() : nil
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
    
    func runProcess(scriptContent: String, maxQueueBlockDuration: Double = 3, terminationHandler: ((Process) -> Void)?) {
        serialQueue.async {
            // run synchronously in this queue
            let semaphore = DispatchSemaphore(value: 0)
            let process = Process()
            process.environment = ["PATH":"/usr/local/:/usr/local/bin/:usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin"]
            process.executableURL = URL(fileURLWithPath: "/bin/bash")
            process.arguments = ["-c", scriptContent]
            process.terminationHandler = { process in
                semaphore.signal()  // next task in queue will run right now before or concurrently with terminationhandler
                guard let terminationHandler = terminationHandler else { return }
                terminationHandler(process)
            }
            do {
                try process.run()
            } catch let error {
                print("error running script: \(error), script: \(scriptContent)")
            }
            _ = semaphore.wait(timeout: .now() + maxQueueBlockDuration)
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
//        self.shouldShowProgress(true, text: "Updating node...", showPercent: false)
        let scriptPath = Bundle.main.path(forResource: "koinos-reload", ofType: "sh") ?? ""
        let scriptContent = "source '\(scriptPath)' '\(dataModel.containerDirectory)' '\(dataModel.producerAddress)' '\(dataModel.minerPrivateKey)' '\(dataModel.version)'"
        runProcess(scriptContent: scriptContent, maxQueueBlockDuration: 30, terminationHandler: { _ in
            DispatchQueue.main.async {
                self.genericRunning = false
//                self.shouldShowProgress(false)
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
        runProcess(scriptContent: scriptContent, maxQueueBlockDuration: 10, terminationHandler: { _ in
            DispatchQueue.main.async {
                self.nodeRunning = false
            }
        })
    }
    func stopNode() {
        genericRunning = true
        applicationCanTerminate = false
        self.shouldShowProgress(true, text: "Stopping node...", showPercent: false)
        let scriptContent = "cd '\(containerDirectory)koinos'; docker compose --profile all down"
        runProcess(scriptContent: scriptContent, terminationHandler: { _ in
            DispatchQueue.main.async {
                self.genericRunning = false;
                self.nodeRunning = false
                self.shouldShowProgress(false)
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
    func openLog(path: String) {
        let scriptContent = "open '\(dataModel.containerDirectory).koinos/\(path)'"
        print(scriptContent)
        runProcess(scriptContent: scriptContent, terminationHandler: { _ in
        })
    }
    func updateDockerState() {
//        print("updateDockerState with current state = \(dockerState)")
        guard dockerState != .error else { return }
        let scriptContent = "docker info > /dev/null 2>&1"  // is docker running now?
        runProcess(scriptContent: scriptContent, terminationHandler: { process in
            if (process.terminationStatus == 0) {
                DispatchQueue.main.async { self.dockerState = .started }
                return
            }
            if (self.dockerState == .started) { // was started, but user shut down or it crashed
                DispatchQueue.main.async { self.dockerState = .error }
                return
            }
            let scriptContent = "docker > /dev/null 2>&1"   // is docker installed
            self.runProcess(scriptContent: scriptContent, terminationHandler: { process in
                if (process.terminationStatus != 0) {
                    DispatchQueue.main.async { self.dockerState = .notInstalled }
                    return
                }
                // start docker if not starting
                if (self.dockerState != .starting) {
                    let scriptContent = "open -gj -a Docker > /dev/null 2>&1"  // start docker
                    self.runProcess(scriptContent: scriptContent, terminationHandler: { process in
                        if (process.terminationStatus == 0) {
                            DispatchQueue.main.async { self.dockerState = .starting }
                            return
                        }
                        self.dockerState = .error
                    })
                }
            })
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
        formatter.dateFormat = "yyyy-MM-dd";
        let dateString = formatter.string(from: Date())
        let panel = NSSavePanel()
        panel.nameFieldLabel = "Save backup as:"
//        panel.nameFieldStringValue = "Koinos-backup-\(dateString).zip"
        panel.nameFieldStringValue = "\(dateString).koinosbackup"
        panel.canCreateDirectories = true
        panel.begin { response in
          if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
//              print(fileUrl)
              panel.orderOut(nil)
//              self.shouldShowProgress(true, text: "Creating backup")
              self.shouldShowProgress(true, text: "Creating backup", showPercent: false)
              DispatchQueue.global(qos: .background).async {
                  self.saveBackupToUrl(url: fileUrl)
              }
          }
        }
    }
    func saveBackupToUrl(url: URL) {
        
        let fm = FileManager.default
        _ = try? fm.removeItem(at: url)
        let scriptContent = """
            cp -R '\(containerDirectory).koinos' '\(url.path)';
            rm '\(url.path)/block_producer/private.key';
            rm '\(url.path)/block_producer/public.key';
            rm -r '\(url.path)/block_producer/logs';
            rm -r '\(url.path)/block_store/logs';
            rm -r '\(url.path)/chain/logs';
            rm -r '\(url.path)/contract_meta_store/logs';
            rm -r '\(url.path)/jsonrpc/logs';
            rm -r '\(url.path)/mempool/logs';
            rm -r '\(url.path)/p2p/logs';
            rm -r '\(url.path)/transaction_store/logs';
        """
//        print(scriptContent)
        runProcess(scriptContent: scriptContent, terminationHandler: { process in
            DispatchQueue.main.async {
                self.shouldShowProgress(false)
                self.showSuccessAlert(text: "Backup complete")
            }
        })
    }
    func restoreFromBackup() {
        let panel = NSOpenPanel()
        panel.nameFieldLabel = "Open backup"
        panel.canCreateDirectories = true
        panel.begin { response in
          if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
              panel.orderOut(nil)
              self.shouldShowProgress(true, text: "Restoring from backup", showPercent: false)
              DispatchQueue.global(qos: .background).async {
                  let fm = FileManager.default
                  _ = try? fm.removeItem(at: URL(fileURLWithPath: "\(self.containerDirectory).koinos"))
                  let scriptContent = "cp -R '\(fileUrl.path)' '\(self.containerDirectory)'.koinos;"
//                  print(scriptContent)
                  self.runProcess(scriptContent: scriptContent, terminationHandler: { process in
                      DispatchQueue.main.async {
                          self.shouldShowProgress(false)
                          self.showSuccessAlert(text: "Restore complete")
                          self.nodeRequiresReload = true
                      }
                  })
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
    func getChainId(callback: @escaping (String?, Error?) -> Void) {
        KoinosDataModel.koinosCall(host: "http://localhost:8080", method: "chain.get_chain_id", params: nil) { (reply: Data?, error: Error?) in
            if (error != nil) { callback(nil, error) }
            else {
                let dictionary = KoinosDataModel.dictionaryFromJSON(json: reply!)
                let result = dictionary["result"] as? [String: String] ?? [String:String]()
                let chainId = result["chain_id"] ?? ""
                callback(chainId, nil)
            }
        }
    }
    func updateChainFatalErrorStatus() {
        getChainId() { (id: String?, error: Error?) in
            struct Holder { static var timesCalled = 0 }
            let rpcRunning = self.nodeBlockHeight > 0
            let chainRunning = id != ""
            if chainRunning || !self.nodeRunning {
                Holder.timesCalled = 0
            }
            if rpcRunning && !chainRunning {
                Holder.timesCalled += 1
            }
            self.chainFatalError = Holder.timesCalled > 5
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
                var balanceBase64 = result["result"] ?? ""
                let b = try? Koinos_Contracts_Token_balance_object(serializedData: Data(base64urlEncoded: balanceBase64) ?? Data())
                callback(Int(b?.value ?? 0), nil)
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
