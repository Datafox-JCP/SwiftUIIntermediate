//
//  LongPressGestureView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 29/05/23.
//

import SwiftUI

struct LongPressGestureView: View {
    
    // MARK: Propiedades
    
    @State var isComplete = false
    @State var isSuccess = false
    
    // MARK: View
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Rectangle()
                    .fill(isSuccess ? Color.green : Color.yellow)
                    .frame(maxWidth: isComplete ? .infinity : 0)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.orange)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                HStack {
                    Text("Clic aquí")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(16)
                        .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 100) { (isPressing) in
                            // comienza el press -> duración mínima
                            if isPressing {
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    isComplete = true
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if !isSuccess {
                                        withAnimation(.easeInOut) {
                                            isComplete = false
                                        }
                                    }
                                }
                            }
                        } perform: {
                            // en la duración mínima
                            withAnimation(.easeInOut) {
                                isSuccess = true
                            }
                        }
                    
                    Text("Restaurar")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(16)
                        .onTapGesture {
                            isComplete = false
                            isSuccess = false
                        }
                } // HStack
            } // VStack
            
            Spacer()
            
            Text(isComplete ? "Completado" : "No completado")
                .padding()
                .padding(.horizontal)
                .background(isComplete ? .green : .red)
                .cornerRadius(16)
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                    isComplete.toggle()
                }
                .padding(.bottom, 50)
        } // VStack
    }
}

// MARK: Preview
struct LongPressGestureView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureView()
    }
}
