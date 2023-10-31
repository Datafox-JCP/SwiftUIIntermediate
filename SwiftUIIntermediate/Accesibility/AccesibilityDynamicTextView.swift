//
//  AccesibilityDynamicTextView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 13/10/23.
//

import SwiftUI

struct AccesibilityDynamicTextView: View {
    
    // 5 para aplicar el minimumScaleFactor sólo a tamaños grandes
//    @Environment(\.dynamicTypeSize) var sizeCategory
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        NavigationStack {
            List(0 ..< 10) { _ in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "figure.mind.and.body")
                            .foregroundStyle(.teal)
                            .font(.system(size: 30))
                        Text("SwiftUI Intermedio")
                            // 1
                            .truncationMode(.tail)
                    } // HStack
                    .font(.title)
                    
                    Text("If you can imagine it, then you can achieve it, but it might take a lot of time, it might take a lot of hard work. If you want something you’ve never had, you have to do something you’ve never done.")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        // 1
                        .truncationMode(.middle)
                        // 3
                        .lineLimit(3)
                        // 4 para que se muestre todo el texto en el linelimit
//                        .minimumScaleFactor(0.7)
                        // 6 muestra de Sizecategory
//                        .minimumScaleFactor(sizeCategory == .extraLarge ? 0.7 : 1.0)
                        .minimumScaleFactor(sizeCategory.customMinScaleFactor)
                } // VStack
                  // 2 comentar la línea y mostrar la diferencia
//                .frame(height: 100)
                .background(Color.gray)
            } // List
            .listStyle(PlainListStyle())
            .navigationTitle("Accesibilidad")
        } // Nav
    }
}

#Preview {
    AccesibilityDynamicTextView()
}


// 7
extension ContentSizeCategory {
    
    var customMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1.0
        case .large, .extraLarge, .extraExtraExtraLarge:
            return 0.7
        default:
            return 0.6
        }
    }
}
