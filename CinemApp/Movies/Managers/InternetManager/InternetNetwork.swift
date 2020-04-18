//
//  InternetNetwork.swift
//  CinemApp
//
//  Created by Josiah Agosto on 3/24/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import Network

// TODO: Fix where it comes back when internet is back online
// TODO: Also All Tests

class InternetNetwork {
    static let shared = InternetNetwork()
    private var monitor: NWPathMonitor?
    var isMonitoring = false
    
    public func checkForInternetConnectivity() {
        startMonitoring()
    }
    
    
    private func startMonitoring() {
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Network_Monitoring")
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                print("Error!")
                DispatchQueue.main.async {
                    NotificationController.displayError(message: APIError.noInternetConnection.localizedDescription)
                }
            }
        }
        isMonitoring = true
    }
    
    
    private func stopMonitoring() {
        guard let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
    }
    
    
    deinit {
        stopMonitoring()
    }
    
}
