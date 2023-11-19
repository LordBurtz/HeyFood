//
//  EventTest.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI
import EventKit

struct CalendarView: View {
    let eventStore = EKEventStore()
    @State private var events: [EKEvent] = []

    var body: some View {
        List(events, id: \.self) { event in
            Text(event.title)
        }
        .onAppear {
            requestAccess()
        }
    }

    private func requestAccess() {
        eventStore.reset()
        eventStore.requestFullAccessToEvents { granted, error in
            if granted {
                let endDate = Date().addingTimeInterval(60 * 60 * 24 * 7) // 7 days from now
                let predicate = eventStore.predicateForEvents(withStart: Date(), end: endDate, calendars: nil)
                events = eventStore.events(matching: predicate)
            }
        }
        eventStore.requestWriteOnlyAccessToEvents { granted, error in
            if granted {
                
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            CalendarView()
                .navigationBarTitle("Calendar")
        }
    }
}

struct EventTest: View {
    var body: some View {
        ContentView()
    }
}

#Preview {
    EventTest()
}
