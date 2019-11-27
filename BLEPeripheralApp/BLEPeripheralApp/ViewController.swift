//
//  ViewController.swift
//  BLEPeripheralApp
//
//  Created by Akshata Kulkarni on 03/09/19.
//  Copyright © 2019 Akshata Kulkarni. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController,CBPeripheralManagerDelegate {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var readValueLabel: UILabel!
    @IBOutlet weak var writeValueLabel: UILabel!
    
    
    private var service: CBUUID!
    private let value = "AD34E"
    private var peripheralManager : CBPeripheralManager!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
       
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
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

    func addServices() {
        
        let valueData = value.data(using: .utf8)
        
        // 1. Create instance of CBMutableCharcateristic
        let myCharacteristic1 = CBMutableCharacteristic(type: CBUUID(nsuuid: UUID()), properties: [.notify, .write, .read], value: nil, permissions: [.readable, .writeable])
        let myCharacteristic2 = CBMutableCharacteristic(type: CBUUID(nsuuid: UUID()), properties: [.read], value: valueData, permissions: [.readable])
       
        // 2. Create instance of CBMutableService
        service = CBUUID(nsuuid: UUID())
        let myService = CBMutableService(type: service, primary: true)
        
        // 3. Add characteristics to the service
        myService.characteristics = [myCharacteristic1, myCharacteristic2]
        
        // 4. Add service to peripheralManager
        peripheralManager.add(myService)
        
        // 5. Start advertising
        startAdvertising()
       
    }
    
    
    func startAdvertising() {

        messageLabel.text = "Advertising Data"
        peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey : "BLEPeripheralApp", CBAdvertisementDataServiceUUIDsKey : [service]])
        print("Started Advertising")
        
    }
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        
        messageLabel.text = "Data getting Read"
        readValueLabel.text = value
      
        // Perform your additional operations here
        
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
        messageLabel.text = "Writing Data"
       
        if let value = requests.first?.value {
           writeValueLabel.text = value.hexEncodedString()
            //Perform here your additional operations on the data you get
        }
    }
    
    

}


extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
