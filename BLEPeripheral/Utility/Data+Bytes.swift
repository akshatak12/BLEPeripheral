//
//  Data+Bytes.swift
//  BLEPeripheral
//
//  Created by Brandon Fraune on 9/4/22.
//

import Foundation

extension Data {
    public var bytes: [UInt8]
    {
        return [UInt8](self)
    }
}
