//
//  BackgroundThreadView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 29/06/23.
//

import SwiftUI

// 1
class BackgroundThreadViewModel: ObservableObject {
    // 4
    @Published var dataArray: [String] = []
    
    // 6 las dos funciones
    func fetchData() {
        // 8
//        let newData = downloadData()
//        dataArray = newData
        
        // 11 comentar los anteriores
//        DispatchQueue.global().async {
//            // self crea un strin reference
//            let newData = self.downloadData()
//            self.dataArray = newData
//        }
        
        // 12 al ejecutar lo anterior observar la advertencia
        // 13
        DispatchQueue.global().async {
            let newData = self.downloadData()
            
            // 16
            print("Verificar 1: \(Thread.isMainThread)")
            print("Verificar 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Verificar 2: \(Thread.isMainThread)")
                print("Verificar 2: \(Thread.current)")
            }
        }
        // mostrar el debug navigator para CPU y explicar
        
        // 14 explicar los quos y pasa a 15
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
    }
    
    // 9 declarar private para download
    private func downloadData() -> [String] {
        // 7
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("Elemento \(x)")
            print(data)
        }
        return data
    }
    
}

struct BackgroundThreadView: View {
    // 2
    @StateObject private var vm = BackgroundThreadViewModel()
    
    var body: some View {
        // 3
        ScrollView {
//            VStack(alignment: .leading, spacing: 12) {
            // 15
            LazyVStack(alignment: .leading, spacing: 12) {
                Text("Cargar Datos")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                // 10
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                // 5
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.brown)
                }
            }
        }
    }
}

struct BackgroundThreadView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadView()
    }
}
