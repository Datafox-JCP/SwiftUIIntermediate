//
//  NetworkMonitorView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 12/09/23.
//

import SwiftUI
import Network
import Observation

@Observable class NetworkMonitor {
    
    var isActive = false
    var isExpensive = false
    var isConstrained = false
    var connectionType = NWInterface.InterfaceType.other
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
                self.isExpensive = path.isExpensive
                self.isConstrained = path.isConstrained
                
                let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet, .loopback]
                self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
            }
        }
        
        monitor.start(queue: queue)
    }
    
}

struct NetworkMonitorView: View {
    
    private var networkMonitor = NetworkMonitor()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(verbatim: "Conectado: \(networkMonitor.isActive)")
            Text(verbatim: "Modo bajo consumo: \(networkMonitor.isConstrained)")
            Text(verbatim: "Móvil / Hotstop: \(networkMonitor.isExpensive)")
            Text(verbatim: "Tipo: \(networkMonitor.connectionType)")
        }
        
    }
}

#Preview {
    NetworkMonitorView()
}
