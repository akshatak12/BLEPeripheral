//
//  BluetoothViewModel.swift
//  BLEPeripheral
//
//  Created by Brandon Fraune on 8/25/22.
//

import Foundation
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject, CBPeripheralManagerDelegate {
    
    private var peripheralManager: CBPeripheralManager!
    
    @Published var bluetoothState = "none"
    @Published var message = "aaa"
    @Published var readValue = "98.1 ºF"
    @Published var writeValue = ""
    
    private var service: CBUUID!
    private let value = "06760100FFDB07081612310001" // 98.1 ºF
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        bluetoothState = peripheral.state.humanReadable()
        switch peripheral.state {
        case .unknown:
            print("Bluetooth Device is UNKNOWN")
        case .unsupported:
            print("Bluetooth Device is UNSUPPORTED")
        case .unauthorized:
            print("Bluetooth Device is UNAUTHORIZED")
        case .resetting:
            print("Bluetooth Device is RESETTING")
        case .poweredOff:
            print("Bluetooth Device is POWERED OFF")
        case .poweredOn:
            print("Bluetooth Device is POWERED ON")
            addServices()
        @unknown default:
            fatalError()
        }
    }
    
    private func addServices() {
        let valueData = value.hexadecimal
        
        // 1. Create instance of CBMutableCharcateristic // Temperature Measurement GATT Characteristic
        // let characteristic1 = CBMutableCharacteristic(type: CBUUID(string: "2A1C"), properties: [.read], value: valueData, permissions: [.readable]) // simple read
        let characteristic2 = CBMutableCharacteristic(type: CBUUID(string: "2A1C"), properties: [.notify], value: nil, permissions: [.readable]) // notify only
        // let characteristic3 = CBMutableCharacteristic(type: CBUUID(string: "2A1C"), properties: [.notify, .write, .read], value: nil, permissions: [.readable, .writeable])
        
        // 2. Create instance of CBMutableService // Health Thermometer GATT service
        let service = CBMutableService(type: CBUUID(string: "1809"), primary: true)
        
        // 3. Add characteristics to the service
        service.characteristics = [characteristic2]
        
        // 4. Add service to peripheralManager
        peripheralManager.add(service)
        
        // 5. Start advertising
        startAdvertising()
    }
    
    private func startAdvertising() {
        message = "Advertising Data"
        peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey : "TAIDOC TD1242-BJF", CBAdvertisementDataServiceUUIDsKey : [service]])
        print("Started Advertising")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        message = "Data getting Read"
//        readValue = value
        
        // Perform your additional operations here
        
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
        message = "Writing Data"
        
//        if let value = requests.first?.value {
//            writeValueLabel.text = value.hexEncodedString()
//            // Perform here your additional operations on the data you get
//        }
    }
}
