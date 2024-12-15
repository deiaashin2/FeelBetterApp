//
//  BrowseJournalEntriesScreen.swift
//  Feel Better App
//
//  Created by Sadia Khan on 11/19/24.
//

import SwiftUI

// Screen for browsing a list of saved journal entries
struct BrowseJournalEntriesScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    // FetchRequest to load journal entries sorted by date in descending order
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)])
    private var journalEntries: FetchedResults<JournalEntry>
    
    var body: some View {
        // List view displaying all journal entries
        List {
            ForEach(journalEntries) { entry in
                NavigationLink(destination: JournalEntryDetailScreen(journalEntry: entry)) {
                    VStack(alignment: .leading) {
                        Text(entry.title ?? "Untitled")
                            .font(.headline)
                        Text(entry.entry ?? "No content")
                            .lineLimit(1)
                            .foregroundColor(.gray)
                        
                        if let date = entry.date {
                            Text(formattedDate(date))
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Journal Entries")
    }

    // Formats a Date object into a user-friendly string
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

