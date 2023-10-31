//
//  NetworkView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 13/09/23.
//

import SwiftUI
import Network

class InternetMonitor: ObservableObject {
    
    private let networkMomnitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    var isConnected = false
    
    init() {
        networkMomnitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send
                }
            }
        }
        networkMomnitor.start(queue: workerQueue)
    }
}

struct NetworkView: View {
    
    @StateObject private var internetMonitor = InternetMonitor()
    
    var body: some View {
        if internetMonitor.isConnected {
            VStack(spacing: 12) {
                Image(systemName: "wifi")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.green)
                
                Text("La conexión a Internet funciona bien")
                    .font(.caption)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
            }
        } else {
            NoNetworkView()
        }
    }
}

#Preview {
    NetworkView()
}
