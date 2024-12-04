//
//  MeditationView.swift
//  Feel Better App
//
//  Created by Andreia Shin on 3/12/24.
//
import SwiftUI
import CoreData

struct MoodDisplay: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MoodEntry.moodType, ascending: true)],
        animation: .default)
    private var moodEntries: FetchedResults<MoodEntry>

    @State private var newMoodNotes: String = ""
    @State private var newMoodType: String = ""

    var body: some View {
        ScrollView {
            VStack {
                Text("Display Mood")
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    Text("Mood")
                        .bold()
                    
                    Spacer()
                    
                    Text("Notes")
                        .bold()
                    
                    Spacer()
                    
                    Text("Date")
                        .bold()
                }
                .padding()
                
                LazyVStack(spacing: 16) {
                    ForEach(moodEntries) { entry in
                        HStack {
                            Text(entry.moodType ?? "Unknown")
                                .frame(width: 100, alignment: .leading)
                            
                            Spacer()
                            
                            Text(entry.moodNotes ?? "No notes")
                                .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(entry.date ?? Date(), style: .date)
                                .frame(width: 120, alignment: .trailing)
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

