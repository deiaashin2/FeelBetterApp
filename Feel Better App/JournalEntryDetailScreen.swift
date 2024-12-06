//
//  JournalEntryDetailScreen.swift
//  Feel Better App
//
//  Created by Sadia Khan on 11/19/24.
//

import SwiftUI

struct JournalEntryDetailScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var entry: String
    @State private var showDeleteConfirmation = false
    
    private var journalEntry: JournalEntry
    
    init(journalEntry: JournalEntry) {
        self.journalEntry = journalEntry
        _title = State(initialValue: journalEntry.title ?? "Untitled")
        _entry = State(initialValue: journalEntry.entry ?? "")
    }
    
    var body: some View {
        Form {
            Section(header: Text("Edit Details")) {
                TextField("Title", text: $title)
                TextEditor(text: $entry)
                    .frame(height: 200)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            }
            
            Section {
                Button("Save Changes") {
                    saveChanges()
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Button("Delete Entry") {
                    showDeleteConfirmation = true
                }
                .foregroundColor(.red)
                .padding()
            }
        }
        .navigationTitle("Journal Entry")
        .confirmationDialog("Are you sure you want to delete this entry?", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                deleteEntry()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private func saveChanges() {
        journalEntry.title = title
        journalEntry.entry = entry
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
    
    private func deleteEntry() {
        viewContext.delete(journalEntry)
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Failed to delete entry: \(error.localizedDescription)")
        }
    }
}
