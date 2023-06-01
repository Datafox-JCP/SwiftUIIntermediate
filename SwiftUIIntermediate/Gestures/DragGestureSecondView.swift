//
//  DragGestureSecondView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 31/05/23.
//

import SwiftUI

struct DragGestureSecondView: View {
    
    // 3
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    // 6
    @State var currentDragOffsetY: CGFloat = 0
    // 11
    @State var endingOffsetY: CGFloat = 0
    
    // 1
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            
            // 2 ya que este terminada, crear subview
            SignUpView()
                // 4
                .offset(y: startingOffsetY)
                // 8 añadir
                .offset(y: currentDragOffsetY)
                // 12
                .offset(y: endingOffsetY)
                // 5
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // 7
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        // 9
                        .onEnded { value in
                            // 10
//                            if currentDragOffsetY < -150 {
//                                // 13 cancelar el startingOffset/
//                                withAnimation(.spring()) {
//                                    endingOffsetY = -startingOffsetY
//                                    currentDragOffsetY = 0
//                                }
//                            }
//
//                            withAnimation(.spring()) {
//                                currentDragOffsetY = 0
//                            }
                            // 14 cambiar lo anterior para que quede así
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                        // 13 cancelar el startingOffset/
                                    withAnimation(.spring()) {
                                        endingOffsetY = -startingOffsetY
                                    }
                                    // 14
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        }
                )
            
        } // ZStack
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureSecondView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureSecondView()
    }
}

struct SignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Ingresar")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Descripción del app. Esta app fue desarrollada en el taller SwiftUI Intermedio. Recomienden este taller a sus amigos, compañeros de trabajo por favaor.")
                .multilineTextAlignment(.center)
            
            Text("CREAR CUENTA")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(16))
            
            Spacer()
        } // VStack
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
