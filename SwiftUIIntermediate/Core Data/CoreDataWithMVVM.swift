//
//  CoreDataWithMVVM.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 21/06/23.
//

import SwiftUI
// 3
import CoreData

/*
 View - UI
 Model - Datos
 ViewModel - Manejador de los datos para el view
 */

// 1
class CoreDataViewModel: ObservableObject {
    // 4
    let container: NSPersistentContainer
    // 8
    @Published var savedEntities: [Book] = []
    
    init() {
        container = NSPersistentContainer(name: "Books")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error cargando Core Data \(error.localizedDescription)")
            } else { // 6
                print("Datos cargados correctamente")
            }
        }
        // 10
        fetchBooks()
    }
    // 5 crear el Data model
    // 7
    func fetchBooks() {
        let request = NSFetchRequest<Book>(entityName: "Book")
        
        do {
            // 9 añadir la variable
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error recuperando datos \(error.localizedDescription)")
        }
    }
    
    // 11
    func addBooks(text: String) {
        let newBook = Book(context: container.viewContext)
        newBook.name = text
        // 13
        saveData()
    }
    
    // 19
    func deleteBook(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    // 21
    func updateBook(entity: Book) {
        // 23
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    // 12
    func saveData() {
        do {
            try container.viewContext.save()
            fetchBooks() // para que se muestre el nuevo libro
        } catch let error {
            print("Error guardando \(error.localizedDescription)")
        }
    }
}

struct CoreDataWithMVVM: View {
    // 2
    @StateObject var vm = CoreDataViewModel()
    // 14
    @State var textFieldBook: String = ""
    
    var body: some View {
        // 15
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Nuevo libro...", text: $textFieldBook)
                    .font(.title)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                Button(action: {
                    // 16
                    guard !textFieldBook.isEmpty else { return }
                    vm.addBooks(text: textFieldBook)
                    // 17
                    textFieldBook = ""
                }, label: {
                    Text("Añadir")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.pink)
                        .cornerRadius(12)
                })
                .padding(.horizontal)
                
                // 18
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "Sin título")
                        // 22
                            .onTapGesture {
                                vm.updateBook(entity: entity)
                            }
                    }
                    // 20
                    .onDelete(perform: vm.deleteBook)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Libros")
    }
}

struct CoreDataWithMVVM_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CoreDataWithMVVM()
        }
    }
}
