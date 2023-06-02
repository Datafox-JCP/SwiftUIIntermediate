//
//  GeometryReader2View.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 01/06/23.
//

import SwiftUI

struct GeometryReader2View: View {
    
    // Para obtener la posición exacta
    // 1
    
    private var images = ["gato", "gatos1", "gatos2", "gatos3", "gatos4", "gatos5", "gatos6", "gatos7", "gatos8", "gatos9"]

    var body: some View {
        
        VStack {
            Text("Taller SwiftUI Intermedio")
                .font(.largeTitle
                )
                .padding(.all)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(images, id: \.self) { image in
                        // 2 colocar la imagen en un Geometry
                        GeometryReader { geometry in
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(30)
                                // 3 sacar de la imagen
    //                            .frame(height: 300)
    //                            .padding()
                                // 4 añadir el efecto
    //                            .rotation3DEffect(
    //                                Angle(degrees: 10),
    //                                axis: (x: 0.0, y: 1.0, z: 0.0))
                                // 6 cambiar para usar el geometry
                                .rotation3DEffect(
                                    Angle(degrees: getPercentage(geo: geometry) * 40),
                                    axis: (x: 0.0, y: 1.0, z: 0.0))
                            
                        } // Geometry el frame debe llevar width y height
                        .frame(width: 300, height: 300)
                        .padding()
                    }
                    // Loop
                } // HStack
            }
        } // Scroll
    }
    
    // 5 añadir función
    // MARK: Funciones
    // GeoProxy es el valor de geometry en el Georeder
    private func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX // para obtener el centro de la imagen
        
        return Double(1 - (currentX / maxDistance))
    }
}

struct GeometryReader2View_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader2View()
    }
}
