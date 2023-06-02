//
//  MaskView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 02/06/23.
//

import SwiftUI

struct MaskView: View {
    
    // 2 añadir
    @State var rating = 0
    
    // 1
    
    var body: some View {
        ZStack {
            // 6 poner starsView
            starsView
                // 10 poner el overlayView
                .overlay (
                    overlayView
                        .mask(starsView)
                    // 7 añadir
//                    GeometryReader { geometry in
//                        ZStack(alignment: .leading) {
//                            // 8 colocar aquí el Rectangle()
//                            Rectangle()
//                                .foregroundColor(.yellow)
//                                .frame(width: CGFloat(rating) / 5 * geometry.size.width)
//                        } // ZStack
//                    } // Geometry
//                    Rectangle()
//                        .mask(starsView)
                )
//            HStack {
//                ForEach(1..<6) { index in
//                    Image(systemName: "star.fill")
//                        .font(.largeTitle)
//                        // 3 modificar la de abajo
////                        .foregroundColor(.gray)
//                        .foregroundColor(rating >= index ? Color.yellow : Color.gray)
//                        // 4 añadir
//                        .onTapGesture {
//                            rating = index
//                        }
//                } // Loop
//            } // HStack
        } // ZStack
    }
    
    // 9 añadir  esto y pasar el Geometry de arriba
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 8 colocar aquí el Rectangle()
                Rectangle()
                    //.foregroundColor(.yellow)
                    // 12 modificar la para usar gradiente
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green,]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            } // ZStack
        } // Geometry
        // 10 para que detecte taps hacia abajo
        .allowsHitTesting(false)
    }
    
    // 5 crear starsView
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        // 11 añadir animación
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            } // Loop
        } // HStack
    }
}

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView()
    }
}
