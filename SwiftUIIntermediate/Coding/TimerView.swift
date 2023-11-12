//
//  TimerView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 21/07/23.
//

import SwiftUI

struct TimerView: View {
    
    let timer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
    
    // Current time
    @State var currentDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    // Countdown
    @State var count = 10
    @State var finishedText: String? = nil

    // Countdown to date
    @State var timeRemaining = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaning() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
    
    // Animation counter
    @State var counter = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
//            Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ?? "\(count)")
            Text(timeRemaining)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
            
//                HStack(spacing: 16) {
//                    Circle()
//                        .offset(y: counter == 1 ? -20 : 0)
//                    Circle()
//                        .offset(y: counter == 2 ? -20 : 0)
//                    Circle()
//                        .offset(y: counter == 3 ? -20 : 0)
//                }
                .frame(width: 150)
                .foregroundColor(.white)
                
                TabView(selection: $counter) {
                    VStack {
                        Image("Imagen1")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                        .tag(1)
                        Text("\"Siempre llegarás a alguna parte si caminas lo bastante.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen2")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(2)
                        Text("\"Nunca, nunca, nunca te rindas.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen3")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(3)
                        Text("\"Convertiste en oscuridad cada centimetro de luz.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen4")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(4)
                        Text("\"No intentar hacer, si no se hace no se intenta.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen5")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(5)
                        Text("\"Esta bien perder con un opnente, no con el miedo.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen6")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(6)
                        Text("\"Hoy, inicia una nueva vida.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen7")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(7)
                        Text("\"No hay camino, forja tu propio camino.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen8")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(8)
                        Text("\"Mantente firme y sige adelante.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen9")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(9)
                        Text("\"Cada uno y para todos.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Image("Imagen10")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .tag(10)
                        Text("\"Mañana incertidumbre, ayer pasado, lo único que tienes es hoy.\"")
                            .font(.system(.title, design: .serif))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal)
                .tabViewStyle(PageTabViewStyle())
            }
        }
        .onReceive(timer) { value in
//            currentDate = value
//            if count < 1 {
//                finishedText = "Terminado"
//            } else {
//                count -= 1
//            }
            
            //updateTimeRemaning()
            
//            if counter == 3 {
//                count = 0
//            } else {
//                counter += 1
//            }
            
            withAnimation(.easeInOut(duration: 1)){
                counter = counter == 10 ? 1 : counter + 1
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
