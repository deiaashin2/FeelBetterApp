//
//  MeditationView.swift
//  Feel Better App
//
//  Created by Andreia Shin on 3/12/24.
//

import SwiftUI

struct MeditationView: View {
    let meditationSteps = [
        ("Find a Quiet Space", "Choose a calm and comfortable spot where you can focus without distractions."),
        ("Sit Comfortably", "Sit in a relaxed but upright posture to support alertness and ease."),
        ("Focus on Your Breath", "Pay attention to your breathing, noticing each inhale and exhale."),
        ("Accept Your Thoughts", "Observe thoughts without judgment, then gently return your focus to the breath."),
        ("End Gradually", "After your session, slowly bring your awareness back to your surroundings.")
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Daily meditation")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                    .padding(.horizontal)
                
                Routinecard()
                    .padding(.horizontal)
                
                Text("5 Tips for Meditation")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                    .padding(.horizontal)
                
                Text("Meditation can give you a sense of calm, peace, and balance that can benefit your emotional well-being and your overall health.")
                    .font(.subheadline)
                    .foregroundColor(.purple)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(meditationSteps, id: \.0) { step in
                            FeaturedExerciseCard(title: step.0, description: step.1)
                        }
                    }
                }
                .padding(.leading, 30)
            }
            .navigationBarHidden(true)
        }
    }
}

struct Routinecard: View {
    var body: some View {
        HStack {
            Image(systemName: "clock")
                .font(.title)
                .foregroundStyle(.white)
                .padding(.leading)
            Text("Morning Routine")
                .foregroundStyle(.white)
            Spacer()
            NavigationLink("Start", destination: VideoView())
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding(.trailing)
        }
        .frame(height: 100)
        .background(Color(.purple))
        .cornerRadius(20)
    }
}

struct FeaturedExerciseCard: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack {
                Rectangle()
                    .frame(width: 300, height: 220)
                    .foregroundColor(Color(.purple))
                    .shadow(radius: 10)
                Image("meditation")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 160, height: 160)
            }
            
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
            Text(description)
                .font(.subheadline)
                .padding(.top, 4)
                .padding(.horizontal, 16)
                .foregroundColor(.gray)
            
            
            Spacer()
        }
        .frame(width: 300, height: 370)
        .cornerRadius(30)
        .background(Color(.white))
    }
}
