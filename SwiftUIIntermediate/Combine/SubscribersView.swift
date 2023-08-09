//
//  SubscribersView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 05/08/23.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count = 0
    @Published var textFieldText = ""
    @Published var textIsValid = false
    @Published var showButton = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpTimer()
        addTextFielSubscriber()
        addButtonSubscriber()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    func addTextFielSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text -> Bool in
                if text.count > 2 {
                    return true
                }
                return false
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count > 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscribersView: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)

            
            TextField("Ingresa tu nombre", text: $vm.textFieldText)
                .padding(.leading, 8)
                .frame(height: 55)
                .font(.subheadline)
                .background(.gray.opacity(0.2))
                .cornerRadius(16)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0 :
                                vm.textIsValid ? 0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                        .font(.title)
                        .padding(.trailing)
                    ,alignment: .trailing
                )
            
            Button(action: {}) {
                Text("Enviar".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

struct SubscribersView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribersView()
    }
}
