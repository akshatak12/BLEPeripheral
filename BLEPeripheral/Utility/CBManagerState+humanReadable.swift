//
//  CBManagerState+humanReadable.swift
//  BLEPeripheral
//
//  Created by Brandon Fraune on 8/31/22.
//

import Foundation
import CoreBluetooth

extension CBManagerState {
    func humanReadable() -> String {
        switch self {
        case .unknown:
            return "unknown"
        case .resetting:
            return "resetting"
        case .unsupported:
            return "unsupported"
        case .unauthorized:
            return "unauthorized"
        case .poweredOff:
            return "poweredOff"
        case .poweredOn:
            return "poweredOn"
        @unknown default:
            return "Need to update code to handle updated CBManagerState enum"
        }
    }
}
