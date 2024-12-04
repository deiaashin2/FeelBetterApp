//
//  MeditationView.swift
//  Feel Better App
//
//  Created by Andreia Shin on 3/12/24.
//
import SwiftUI
import CoreData

struct MoodChartView: View {
    @State private var feelingtext: String = ""
    @State private var selectedMood: String = ""
    
    // Core Data context
    @Environment(\.managedObjectContext) private var viewContext
    
    // Presentation mode for dismissing view after save
    @Environment(\.presentationMode) private var presentationMode

    // Fetch the MoodEntry entities from Core Data
    @FetchRequest(entity: MoodEntry.entity(), sortDescriptors: [])
    private var moodEntries: FetchedResults<MoodEntry>
    
    // Computed properties to count moods
    private var happyCount: Int {
        moodEntries.filter { $0.moodType == "Happy" }.count
    }
    
    private var neutralCount: Int {
        moodEntries.filter { $0.moodType == "Neutral" }.count
    }
    
    private var sadCount: Int {
        moodEntries.filter { $0.moodType == "Sad" }.count
    }
    
    private var angryCount: Int {
        moodEntries.filter { $0.moodType == "Angry" }.count
    }
    
    var body: some View {
        NavigationStack {
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        
                        VStack {
                            moodTypeText("Happy", color: .yellow)
                            moodTypeText("Neutral", color: .gray)
                            moodTypeText("Sad", color: .blue)
                            moodTypeText("Angry", color: .red)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            CircleProgressView(progress: .constant(Int(Double(happyCount))), color: .yellow, goal: 30)
                            CircleProgressView(progress: .constant(Int(Double(neutralCount))), color: .gray, goal: 30)
                                .padding(.all, 20)
                            CircleProgressView(progress: .constant(Int(Double(sadCount))), color: .blue, goal: 30)
                                .padding(.all, 40)
                            CircleProgressView(progress: .constant(Int(Double(angryCount))), color: .red, goal: 30)
                                .padding(.all, 60)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            HStack() {
                    Text("Mood history")
                        .font(.title2)
                    Spacer()
                    
                    NavigationLink {
                        MoodDisplay()
                    } label: {
                        Text("Show more")
                            .padding(.all, 10)
                            .foregroundColor(.white)
                            .background(.purple)
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal)
                
                VStack {
                    Text("How are you feeling today?")
                        .font(.headline)
                        .bold()
                    
                    HStack(alignment: .center) {
                        EmotionButton(moodType: "Angry", selectedMood: $selectedMood)
                        EmotionButton(moodType: "Sad", selectedMood: $selectedMood)
                        EmotionButton(moodType: "Neutral", selectedMood: $selectedMood)
                        EmotionButton(moodType: "Happy", selectedMood: $selectedMood)
                    }
                    .padding(.horizontal)
                    
                    TextField("Type here", text: $feelingtext)
                        .frame(maxHeight: 120)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke())
                        .padding(.horizontal)
                    
                    Button {
                        saveMoodEntry()
                    } label: {
                        Text("Submit")
                            .foregroundColor(.purple)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.black)))
                    }
                    
                    Spacer()
                    
                    // Optionally show the submitted mood entry with date confirmation
                    if !selectedMood.isEmpty {
                        Text("Your mood has been selected!")
                            .foregroundColor(.purple)
                            .padding(.top)
                    }
                }
                .padding()
            }
    }
    
    // Helper function to display mood type text
    private func moodTypeText(_ mood: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(mood)
                .font(.callout)
                .bold()
                .foregroundColor(color)
        }
        .padding(.bottom)
    }
    
    // Save MoodEntry to Core Data
    private func saveMoodEntry() {
        let newMoodEntry = MoodEntry(context: viewContext)
        newMoodEntry.moodType = selectedMood
        newMoodEntry.moodNotes = feelingtext
        newMoodEntry.date = Date() // Save the current date
        
        do {
            try viewContext.save()
            feelingtext = "" // Clear the text field after saving
            selectedMood = "" // Clear the selected mood after submitting
            presentationMode.wrappedValue.dismiss() // Close the view after saving
        } catch {
            print("Failed to save mood entry: \(error)")
        }
    }
}

struct EmotionButton: View {
    var moodType: String
    @Binding var selectedMood: String
    
    var body: some View {
        Button {
            selectedMood = moodType // Set the selected mood
        } label: {
            Image(moodType.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 70)
        }
    }
}
