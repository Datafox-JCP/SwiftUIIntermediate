//
//  LongPressGestureView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 29/05/23.
//

import SwiftUI

struct LongPressGestureView: View {
        // 2
        @State private var isComplete = false
        // 12
        @State private var isSucess = false
        
        var body: some View {
            // 1
    //        Text("SwiftUI Intermedio")
            // 3
            VStack(spacing: 50) {
                Text(isComplete ? "SwiftUI Intermedio" : "Iniciando")
                    .padding()
                    .padding(.horizontal)
                    // 4
                    .background(isComplete ? .green : .red)
                    .cornerRadius(12)
                    // 5
        //            .onTapGesture {
        //                isComplete.toggle()
        //            }
                    // 6 comentar el 5
        //            .onLongPressGesture {
                    // 7 añadir minDuration
        //            .onLongPressGesture(minimumDuration: 5.0) {
                    // 8 añadir maximimunDistance
                    .onLongPressGesture(minimumDuration: 5.0, maximumDistance: 100) {
                        isComplete.toggle()
                    }
                // 9 Poner el text en el VStack y luego esto:
                Rectangle()
    //                .fill(Color.blue)
                    // 14 cambiar a
                    .fill(isSucess ? Color.green : Color.yellow)
    //                .frame(maxWidth: 10)
                    // 11 cambiar a
                    .frame(maxWidth: isComplete ? .infinity : 0)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.orange)
                
                HStack {
                    Text("Clic aquí")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                        //10
                        .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { isPressing in
                            // comienza a presionar
                            if isPressing {
                                withAnimation(.easeIn(duration: 1.0)) {
                                    isComplete.toggle()
                                }
                                // 14 añadir el else
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if !isSucess {
                                        withAnimation(.easeInOut) {
                                            isComplete = false
                                        }
                                    }
                                }
                            }
                        } perform: {
                            // 13
                            withAnimation(.easeIn) {
                                isSucess = true
                            }
                        }
                    
                    Text("Resetear")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                        // 15
                        .onTapGesture {
                            isComplete = false
                            isSucess = false
                        }
                } // HStack
            } // VStack
        }
}

// MARK: Preview
struct LongPressGestureView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureView()
    }
}
