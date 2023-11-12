//
//  ThumbnailView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 12/11/23.
//

import SwiftUI

struct ThumbnailView: View, Identifiable {
    var id = UUID()
    @ViewBuilder var content: any View
    
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}

//#Preview {
//    ThumbnailView()
//}
