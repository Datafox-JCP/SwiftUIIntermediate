//
//  NoNetworkView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 13/09/23.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "wifi.slash")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.red)
            
            Text("La conexión a Internet parace no funcionar. \nFavor de verificar")
                .font(.caption)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    NoNetworkView()
}
