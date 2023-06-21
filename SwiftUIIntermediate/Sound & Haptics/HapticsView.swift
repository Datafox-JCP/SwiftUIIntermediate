//
//  HapticsView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 04/06/23.
//

import SwiftUI

// 1
class HapticManager {
    
    static let instance = HapticManager()
    
    // 2 funciones vacias
    // 4 añadir type a la función
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        // 3 completar
        let generator = UINotificationFeedbackGenerator()
        
        generator.notificationOccurred(type)
    }
    
    // 6 añadir es estilo a la función
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
            // 5 completar
        let generator = UIImpactFeedbackGenerator(style: style)
        
        generator.impactOccurred()
    }
    
    func selection() {
        let generator = UISelectionFeedbackGenerator()
        
        generator.selectionChanged()
    }
}

struct HapticsView: View {
    var body: some View {
        // 7 comienza vacia, reemplazar por
        VStack(spacing: 20) {
            GroupBox {
                Button {
                    HapticManager.instance.notification(type: .success)
                } label: {
                    Text("Completado")
                }
                Button {
                    HapticManager.instance.notification(type: .warning)
                } label: {
                    Text("Advertencia")
                }
                Button {
                    HapticManager.instance.notification(type: .error)
                } label: {
                    Text("Error")
                }
                Button {
                    HapticManager.instance.selection()
                } label: {
                    Text("Sistema")
                }
            } label: {
                Text("Notification type")
            }

            
            Divider()
            
            GroupBox {
                Button {
                    HapticManager.instance.impact(style: .heavy)
                } label: {
                    Text("Fuerte")
                }
                Button {
                    HapticManager.instance.impact(style: .light)
                } label: {
                    Text("Tenue")
                }
                Button {
                    HapticManager.instance.impact(style: .medium)
                } label: {
                    Text("Media")
                }
                Button {
                    HapticManager.instance.impact(style: .rigid)
                } label: {
                    Text("Rígida")
                }
                Button {
                    HapticManager.instance.impact(style: .soft)
                } label: {
                    Text("Suave")
                }
            } label: {
                Text("Impact")
            }

        } // VSTack
        .buttonStyle(.bordered)
    }
}

struct HapticsView_Previews: PreviewProvider {
    static var previews: some View {
        HapticsView()
    }
}
