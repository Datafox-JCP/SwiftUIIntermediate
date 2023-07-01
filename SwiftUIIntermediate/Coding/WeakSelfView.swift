//
//  WeakSelfView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 29/06/23.
//

import SwiftUI

struct WeakSelfView: View {
    // 9
    @AppStorage("count") var count: Int?
    
    // 13 observar como no sube de 1 al ejecuarlo en simulador o preview
    init() {
        count = 0
    }
    
    var body: some View {
        // 1
        NavigationStack {
            NavigationLink("Navegar") {
//                Text("")
                // 3
                WeakSelfSecondScreen()
            }
            .navigationTitle("Vista 1")
        }
        // 8
        .overlay(
//            Text("1")
            // 10
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(12))
            , alignment: .topTrailing
        )
    }
}

// 2
struct WeakSelfSecondScreen: View {
    // 5
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
//        Text("Segunda vista")
//            .font(.largeTitle)
//            .foregroundColor(.mint)
        // 6
        VStack {
            Text("Segunda vista")
                .font(.largeTitle)
                .foregroundColor(.mint)
            
            if let data = vm.data {
                Text(data)
            }
        }
        // 7 probar en el simulador y ver los mensajes print
    }
}

// 4
class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("Inicializando")
        // 11 poner antes de getData
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        // 12 poner antes del print
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
        print("Deinicializando")
    }
    
//    func getData() {
//        data = "Nuevos datos"
//    }
    
    // 14 explicar como se queda la referencia self.data
    // ya que se necesita que esos datos queden con vida
    func getData() {
        // 15 pero para prevenir que esto cause referencias
        // añadir [weak self] in
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "Nuevos datos"
        }
    }
}

struct WeakSelfView_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfView()
    }
}
