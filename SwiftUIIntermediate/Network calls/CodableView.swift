//
//  CodableView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 01/07/23.
//

import SwiftUI

// 3
//struct CustomerModel: Identifiable{
//12
//struct CustomerModel: Identifiable, Decodable {
// 16
//struct CustomerModel: Identifiable, Decodable, Encodable {
// 19 y dejar sólo el modelo
    struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isFavorite: Bool
    
//    // 13
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isFavorite
//    }
//    
//    // 11
//    init(id: String, name: String, points: Int, isFavorite: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isFavorite = isFavorite
//    }
//    
//    // 14
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
//    }
//    
//    // 17
//    func enconde(to enconder: Encoder) throws {
//        var container = try enconder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isFavorite, forKey: .isFavorite)
//    }
    
}

// 1
class CodableViewModel: ObservableObject {
    // 4
    @Published var customer: CustomerModel? = CustomerModel(id: "1", name: "Luis Felipe", points: 45, isFavorite: false)
    
    // 6 init con getData() {
    init() {
        getData()
    }
    
    func getData() {
        // 8
        guard let data = getJSONData() else { return }
        
        print("JSON")
        print(data) // ver el resultado
        
        // 9 y después ver el resultado de estas dos líneas
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString as Any)
        
        // 10 colocar y ver el resultado en el preview
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data),
//            let dictionary = localData as? [String:Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isFavorite = dictionary["isFavorite"] as? Bool {
//
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isFavorite: isFavorite)
//            customer = newCustomer
//        }
        
        // 15 comentar el bloque anterior y después el do
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print("Error decodificando. \(error)")
        }
        // si se quisiera en una línea
        // self.customer = try? JSONDecoder().decode(CustomerModel.self,
    }
    
    // 7
    func getJSONData() -> Data? {
        // 18 y comentar dictionary jsonData
        let customer = CustomerModel(id: "234", name: "Luisa", points: 99, isFavorite: true)
//        let dictionary: [String:Any] = [
//            "id" : "12345",
//            "name" : "Juan Carlos",
//            "points" : 22,
//            "isFavorite" : false
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonData = try? JSONEncoder().encode(customer)
        
        return jsonData
    }
}


struct CodableView: View {
    
    // 2
    @StateObject private var vm = CodableViewModel()
    
    var body: some View {
        // 5
        VStack(spacing: 16) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isFavorite.description)
            }
        }
    }
}

struct CodableView_Previews: PreviewProvider {
    static var previews: some View {
        CodableView()
    }
}
