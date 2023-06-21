//
//  LocalNotificationView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 05/06/23.
//

import SwiftUI
import UserNotifications // 4
import CoreLocation // 14
// 2
class NotificationManager {
    
    static let instance = NotificationManager()     // Singleton
    
    // 3
    func requestAuthorization() {
        // 5
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error {
                print("Error \(error)")
            } else {
                print("Funciona")
            }
        }
    }

    // 7
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Taller SwiftUI Intermedio"
        content.subtitle = "Son más sencillas de lo que se podría pensar"
        content.sound = .default
        content.badge = 1
        
        // 8
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        //11
        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 30
        // 12 probar lo anterior y despues
        dateComponents.weekday = 2
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 13
        // location
        // 15
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        region.notifyOnExit = true
        region.notifyOnEntry = false
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger) // colocar el 8 primero
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // 16
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationView: View {
    
    // 1
    var body: some View {
        GroupBox {
            Button("Solicitar permiso") {
                    // 6
                NotificationManager.instance.requestAuthorization()
            }
            .padding(.vertical)
                // 9
            Button("Programar notificación") {
                NotificationManager.instance.scheduleNotification()
            }
            .padding(.vertical)
            // 17
            Button("Cancelar notificaciones") {
                NotificationManager.instance.cancelNotifications()
            }
            .padding(.vertical)
        } label: {
            Text("Notificaciones")
        }
            // 10 para resetear el badge
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        .buttonStyle(.bordered)
    }
}

struct LocalNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationView()
    }
}
