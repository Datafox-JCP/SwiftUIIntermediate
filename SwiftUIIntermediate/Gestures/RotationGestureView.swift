//
//  RotationGestureView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 31/05/23.
//

import SwiftUI

struct RotationGestureView: View {
    
    // 4
    @State var angle: Angle = Angle(degrees: 0)
    
        // 1
    var body: some View {
        Text("Rotation Gesture")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(40)
            .background(Color.green.cornerRadius(16))
            // 3
            .rotationEffect(angle)
            .padding(.horizontal)
            // 2
            .gesture(
                RotationGesture()
                    .onChanged{ value in
                        angle = value
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

struct RotationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureView()
    }
}
