//
//  EscapingView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 30/06/23.
//

import SwiftUI

// 1
class EscapingViewModel: ObservableObject {
    // 3
    @Published var text = "SwiftUI Intermedio"
    
    // 5
    func getData() {
        // 8
//        let newData = downloadData()
//        text = newData
        
        // 11 y comentar la de arriba
//        downloadData2 { data in
//            text = data
//        }
        
        // 13 y comentar la de arriba
//        downloadData3 { data in
//            self.text = data
//        }
        
        // 14 igual pero ahora weak self
//        downloadData3 { [weak self] data in
//            self?.text = data
//        }
        // 17
        downloadData4 { [weak self] result in
            self?.text = result.data
        }
        
        // 20
        downloadData5 { [weak self] result in
            self?.text = result.data
        }
    }
    
    // 7 esto es código syncronous
    func downloadData() -> String {
        return "Lección @escaping"
    }
    
    // 9
//    func downloadData2() -> String {
//        // esto es código asyncronous
//        DispatchQueue.main.async(deadline: .now() + 2.0) {
//            return "Leección @escaping"
//        }
//    }
    
    // 10 como lo anterior no funciona
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("Lección @escaping")
    }
    
    // 12 como lo anterior no funciona
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("Lección @escaping")
        }
    }
    
    // 15 copiar la función, hacer el 16 y modificar
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Lección @escaping")
            completionHandler(result)
        }
    }
    
    // 18 copiar la función, hacer el 19 y modificar despues con el typealias
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Lección @escaping")
            completionHandler(result)
        }
    }
}

// 16
struct DownloadResult {
    let data: String
}

// 19
typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingView: View {
    // 2
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        // 4
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.brown)
        // 6
            .onTapGesture {
                vm.getData()
            }
        
    }
}

struct EscapingView_Previews: PreviewProvider {
    static var previews: some View {
        EscapingView()
    }
}
