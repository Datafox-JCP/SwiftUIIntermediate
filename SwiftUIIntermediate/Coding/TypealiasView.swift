//
//  TypealiasView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 29/06/23.
//

import SwiftUI

// 1
struct MovieModel {
    let title: String
    let director: String
    let likesCount: Int
}

// 4
//struct TVModel {
//    let title: String
//    let director: String
//    let likesCount: Int
//}

// 6 comentar la struct anterior
typealias TVModel = MovieModel

struct TypealiasView: View {
    
    // 2
//    @State var item: MovieModel = MovieModel(title: "King Kong", director: "Delaurentis", likesCount: 9000)
    // 5
    @State var item: TVModel = TVModel(title: "Castle", director: "No disponible", likesCount: 90)
    
    var body: some View {
        // 3
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.likesCount)")
        }
    }
}

struct TypealiasView_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasView()
    }
}
