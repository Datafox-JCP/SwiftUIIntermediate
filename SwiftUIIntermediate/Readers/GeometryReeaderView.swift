//
//  GeometryReeaderView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 01/06/23.
//

import SwiftUI

struct GeometryReeaderView: View {
    
    // 1
    var body: some View {
        // 3 añadir geometry
        // geometry obtiene el tamaño del contenido que este dentro de el
        GeometryReader { geometry in
            // 4 mover la HStack aquí
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.blue)
                    // 2 para que mida 2 tercios de la pantalla
                    // demostrar con el simulador como no son dos tercios al cambiar la orientación
//                    .frame(width: UIScreen.main.bounds.width * 0.6666)
                    // 5 ajustar y probar con el emulador
                    .frame(width: geometry.size.width * 0.6666)
                
                Rectangle()
                    .fill(Color.yellow)
            } // HStack
            .ignoresSafeArea()
        } // Geometry
//        HStack(spacing: 0) {
//            Rectangle()
//                .fill(Color.blue)
//                // 2 para que mida 2 tercios de la pantalla
//                // demostrar con el simulador como no son dos tercios al cambiar la orientación
//                .frame(width: UIScreen.main.bounds.width * 0.6666)
//
//            Rectangle()
//                .fill(Color.yellow)
//        } // HStack
//        .ignoresSafeArea()
    }
}

struct GeometryReeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReeaderView()
    }
}
