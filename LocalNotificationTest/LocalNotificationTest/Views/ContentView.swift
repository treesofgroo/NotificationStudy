//
//  ContentView.swift
//  LocalNotificationTest
//
//  Created by Groo on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTime = Date()
    let notify = NotificationHandler()
    
    var body: some View {
        VStack {
            Spacer()
            DatePicker("Pick noti time: ", selection: $selectedTime, in: Date()..., displayedComponents: [.hourAndMinute])
            Button("Send a notification at time") {
                notify.sendNotification(date: selectedTime, type: "calendar", title: "Date Notification", body: "This is calendar notification")
            }
            .buttonStyle(.bordered)
            Button("Send a notification in 5 seconds") {
                notify.sendNotification(date: Date(), type: "timeInterval", timeInterval: 5, title: "Time Notification", body: "This is timeinterval notification")
            }
            .buttonStyle(.bordered)
            Button("Send a notification repeatedly") {
                notify.sendNotification(date: selectedTime, type: "repeat", title: "Repeat Notification", body: "This is repeat notification")
            }
            .buttonStyle(.bordered)
            Button("Send a notification with actions") {
                // Define the custom actions.
                let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
                      title: "Accept",
                      options: [])
                let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                      title: "Decline",
                      options: [])
                // Define the notification type
                let meetingInviteCategory =
                      UNNotificationCategory(identifier: "MEETING_INVITATION",
                      actions: [acceptAction, declineAction],
                      intentIdentifiers: [],
                      hiddenPreviewsBodyPlaceholder: "",
                      options: .customDismissAction)
                // Register the notification type.
                let notificationCenter = UNUserNotificationCenter.current()
                    notify.sendNotification(date: Date(), type: "action", timeInterval: 5, title: "Action Notification", body: "This is timeinterval notification with action")
            }
            .buttonStyle(.bordered)
            Spacer()
            Text("Not working?")
            Button("Request permissions") {
                notify.askPermission()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
