//
//  ExpandedView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 12/11/23.
//

import SwiftUI

struct ExpandedView: View {
    var id = UUID()
    @ViewBuilder var content: any View
    
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}

//#Preview {
//    ExpandedView()
//}
