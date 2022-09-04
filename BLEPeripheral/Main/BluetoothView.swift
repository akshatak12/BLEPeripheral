//
//  BluetoothView.swift
//  BLEPeripheral
//
//  Created by Brandon Fraune on 8/25/22.
//

import SwiftUI

struct BluetoothView: View {
    @StateObject private var viewModel = BluetoothViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("BLE Peripheral App")
                .foregroundColor(.blue)
                .bold()
            
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Text("Bluetooth State:")
                    Text(viewModel.bluetoothState)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Message:")
                    Text(viewModel.message)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Value To Be Read:")
                    Text(viewModel.readValue)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Value Written is:")
                    Text(viewModel.writeValue)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
