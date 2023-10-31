//
//  KeyPathsView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 31/10/23.
//

import SwiftUI

// KeyPath hacen el código más limpio que closures pero sobre todo lo hacen más seguro. Siempre que no se vayan a realizar otras acciones

struct KeyPathsView: View {
    
    @State private var cars = MockData.cars
    
    var body: some View {
        NavigationStack {
            List(cars, id: \.id) { car in
                HStack {
                    Text(car.name)
                    Spacer()
                    Text(car.dailyRate, format: .currency(code: "MXN")).padding(.trailing, 16)
                    Image(systemName: "checkmark.circle.fill").foregroundStyle(.mint)
                        .opacity(car.isAvailble ? 1.0 : 0.0)
                }
            }
            .navigationTitle("Autos en Renta")
            .toolbar {
                Button("Filtro", systemImage: "line.3.horizontal.decrease.circle") {
                    cars = cars.filter { $0.isAvailble }
                    /// En el closure podemos hacer lo que sea siempre que se devuelva un boolean { $0.isAvailble && $0.dailyRate < 800  }
                    /// Keypath aquí
                    cars = cars.filter(\.isAvailble)
                    
                    /// Uso en map
                    let dailyRates = cars.map(\.dailyRate)
                }
            }
        }
    }
}

#Preview {
    KeyPathsView()
}

struct Car {
    var id = UUID()
    var name: String
    var dailyRate: Int
    var isAvailble: Bool
}

struct MockData {
    static let cars: [Car] = [
        .init(name: "Porsche 911 GT3 R3", dailyRate: 900, isAvailble: true),
        .init(name: "Ferrari 458", dailyRate: 829, isAvailble: true),
        .init(name: "Mercedes AMG GT", dailyRate: 759, isAvailble: false),
        .init(name: "BMW M3", dailyRate: 500, isAvailble: false),
        .init(name: "Tesla Model S", dailyRate: 429, isAvailble: true)
    ]
}
