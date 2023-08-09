//
//  ImagesView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 11/09/23.
//

import SwiftUI

struct ImagesView: View {
    var body: some View {
        var imagePath = URL.documentsDirectory.appendingPathComponent("SomeImage.jpg")
        
        VStack {
            Image(.gatos1)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400)
            
//            Label("SwiftUI Intermedio", image: .tolkien)
            
            Image(uiImage: UIImage(contentsOfFile: imagePath.path)
                  ?? UIImage(resource: .imagen4))
                .resizable()
                .scaledToFit()
                .frame(width: 200)
        }
        .padding()
    }
}

#Preview {
    ImagesView()
}

#Preview("Personal preview", traits: .landscapeLeft) {
    ImagesView()
}
