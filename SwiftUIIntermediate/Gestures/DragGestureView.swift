//
//  DragGestureView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 31/05/23.
//

import SwiftUI

struct DragGestureView: View {
    
    // 2
    @State var offset: CGSize = .zero  // offset porque es la distancia de donde estamos a donde queremos ir
    
    // 1
    var body: some View {
        // 6 poner todo en ZStack
        ZStack {
            // 7 para ver a donde nos movemos
            VStack {
                Text("\(offset.width)")
                Spacer()
            }
            // 13 cambiar por imagen
           // RoundedRectangle(cornerRadius: 20)
            Image("gato2")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                // 5 debe quedar como el segundo
    //            .frame(width: 100, height: 100)
                .frame(width: 300, height: 500)
                // 3
                .offset(offset)
                // 8 esto es para cambiar el tamaño al acercarse a los bordes
//                .scaleEffect(1.0)
                // 10 cambiar la anterior para usar la función
                .scaleEffect(getScaleAmount())
                // 15
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // 4
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            // 4
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                )
        }
    }
    
    // 9
    // MARK: Funciones
    // para obtener la escala
    private func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width) // abs es para obtener el valor absoluto
        let percentage = currentAmount / max
        
//        return 1.0 - percentage
        // 11 se modifica para que sólo se reduzca al 50%
//        return 1.0 - min(percentage, 0.5)
        // 12 volver a modificar para que se más lento
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    // 14
    private func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        
        return percentageAsDouble * maxAngle
    }
}

struct DragGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}

