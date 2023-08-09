//
//  PhoneCallView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 10/09/23.
//

import SwiftUI

struct PhoneCallView: View {
    
    let phoneNumber = "5544845398"
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Button {
                        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                            UIApplication.shared.open(phoneURL)
                        }
                    } label: {
                        Label(
                            title: { Text("Llamar") },
                            icon: {  Image(systemName: "phone") }
                        )
                    }

                }
            }
        }
        .navigationTitle("LLamar a un número")
    }
}

#Preview {
    PhoneCallView()
}
