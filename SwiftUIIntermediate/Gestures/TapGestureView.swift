//
//  TapGestureView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 30/05/23.
//

import SwiftUI

/*
 TapGesture & LongPressGesture
 
    - modifiers
    - arguments
    - composite gestures
    - GestureState
 */

struct TapGestureView: View {
    // 2 Añadir
    @State private var isTapped = false
    // 7 añadir (para encadenar gestos
    @State private var isTapped3 = false
    
    var body: some View {
        // 1 construcción original
        Circle()
        // 8 añadir y marcar la de abajo
            .fill(isTapped3 ? Color.green : Color.red)
//            .fill(Color.red)
            .shadow(radius: 20)
            .frame(width: 200)
        // 3 añadir
            .scaleEffect(isTapped ? 0.5 : 1)
            // para iOS 14
            // .animation(.easeInOut(duration: 0.5))
            .animation(.easeInOut(duration: 0.5), value: isTapped)
            // 4 comentar
//            .onTapGesture {
//                isTapped.toggle()
//            }
        // 5 añadir
            .gesture(TapGesture(count: 2) // 6 añadir count
                .onEnded{
                    isTapped.toggle()
                }
                     // 9 comentar el gesto inferior y añadir
                .simultaneously(with: TapGesture(count: 3) // 6 añadir count
                    .onEnded{
                        isTapped3.toggle()
                    })
            )
        // 8 añadir probar pero no funcionará detectar el tercer
//            .gesture(TapGesture(count: 3) // 6 añadir count
//                .onEnded{
//                    isTapped3.toggle()
//                }
//            )
    }
}

struct TapGestureView_Previews: PreviewProvider {
    static var previews: some View {
        TapGestureView()
    }
}
