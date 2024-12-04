//
//  AddJournalEntryScreen.swift
//  Feel Better App
//
//  Created by Sadia Khan on 11/19/24.
//

import SwiftUI

struct AddJournalEntryScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var entry = ""
    @State private var photos: Data?
    @State private var videos: Data?
    
    var body: some View {
        Form {
            Section(header: Text("Journal Details")) {
                TextField("Title", text: $title)
                TextEditor(text: $entry)
                    .frame(height: 150)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            }
            
            Section(header: Text("Attachments")) {
                Button("Add Photo") {
                    // Implement Photo Picker
                }
                Button("Add Video") {
                    // Implement Video Picker
                }
            }
            
            Button("Save") {
                addJournalEntry()
            }
        }
        .navigationTitle("Add Journal Entry")
    }
    
    private func addJournalEntry() {
        let newEntry = JournalEntry(context: viewContext)
        newEntry.title = title
        newEntry.entry = entry
        newEntry.date = Date()
        newEntry.photos = photos
        newEntry.videos = videos
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Failed to save entry: \(error.localizedDescription)")
        }
    }
}
