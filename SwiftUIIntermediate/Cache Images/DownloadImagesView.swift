//
//  DownloadImagesView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 11/08/23.
//

import SwiftUI

// https://via.placeholder.com/600/92c952
// https://jsonplaceholder.typicode.com/photos

struct DownloadImagesView: View {
    
    @State var vm = DownloadImagesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dataArray) { model in
                    Text(model.title)
                }
            }
            .navigationTitle("Descarga de imágenes")
        }
    }
}

struct DownloadImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImagesView()
    }
}
