//
//  TabBarView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 15/06/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Text("Primer view")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.cyan)
                .tabItem {
                    Label("Primero", systemImage: "1.circle")
                }
            
            Text("Segundo view")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.yellow)
                .tabItem {
                    Label("Segundo", systemImage: "2.circle")
                }
        } // Tabview
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
