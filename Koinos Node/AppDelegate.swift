//
//  AppDelegate.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/10/22.
//

import AppKit
import Combine

// clumsy old-style class added to get applicationWillTerminate
class KoinosAppDelegate: NSResponder, NSApplicationDelegate {
    
//    var runningObserver: AnyCancellable?
//    var running: Bool = false
//
//    func observeRunning(model: KoinosDataModel){
//        runningObserver = model.$nodeRunning.sink{ newState in
//            self.running = newState
//            print("\n\n\n\n\n______________________\nNew State: \(newState)\n__________________________________________________________________\n\n\n\n\n\n\n\n\n\n")
//        }
//    }
    
    
    func applicationWillTerminate(_ notification: Notification) {
//        observeRunning(model: dataModel);
        print("will terminate");
        sleep(1)
        dataModel.stopNode()
        var timeoutReached:Bool = false
        var seconds: Int = 0
        while (!dataModel.applicationCanTerminate && !timeoutReached) {
            sleep(1)
            seconds += 1
            timeoutReached = seconds >= dataModel.applicationTerminationTimeout
        }
        print("stopped")
    }
}
