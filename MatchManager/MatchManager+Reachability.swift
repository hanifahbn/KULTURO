//
//  MatchManager+Reachability.swift
//  MacroApp
//
//  Created by Hanifah BN on 20/11/23.
//

import Foundation
import SystemConfiguration

extension MatchManager{
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: nil)
        do {
            try reachability?.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
    
    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    @objc private func reachabilityChanged(_ notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }
        
        if reachability.connection != .unavailable {
            // Internet connection available
            // Perform actions or call a function when the internet connection is restored
            internetConnectionRestored()
        } else {
            // No internet connection
            // Perform actions or call a function when the internet connection is lost
            internetConnectionLost()
        }
    }
    
    private func internetConnectionRestored() {
        // Function to handle restored internet connection
        print("Internet connection restored")
        // Your code to handle the reestablishment of the internet connection
    }
    
    private func internetConnectionLost() {
        // Function to handle lost internet connection
        print("Internet connection lost")
        // Your code to handle the loss of internet connection
    }
}
