//
//  VideoView.swift
//  Feel Better App
//
//  Created by Andreia Shin on 3/12/24.
//

import SwiftUI
import AVFoundation

struct VideoView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var currentTime: TimeInterval = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 0)  {
            Image("meditation2")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)
            
            ZStack {
                Color(.white)
                
                VStack(alignment: .leading, spacing: 24) {
                    // Audio progress bar
                    VStack {
                        Text("Audio Progress")
                            .font(.subheadline)
                            .opacity(0.7)
                        
                        ProgressView(value: currentTime, total: audioPlayer?.duration ?? 1)
                            .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                            .padding(.vertical, 8)
                    }
                    
                    Text("3 Minute Relaxation")
                        .font(.title)
                    
                    // Play/Stop Button
                    Button {
                        toggleAudio()
                    } label: {
                        Label(isPlaying ? "Stop" : "Play", systemImage: isPlaying ? "stop.fill" : "play.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(.purple)
                            .cornerRadius(15)
                    }
                    
                    Text("Meditation is the act of focusing the mind to relax, improve inner awareness, and make positive mental or physical changes.")
                    Spacer()
                }
                .padding()
                .border(Color.gray, width: 1)
            }
            .frame(height: UIScreen.main.bounds.height * 2 / 3)
        }
        .ignoresSafeArea()
        .onAppear {
            prepareAudioPlayer()
        }
        .onDisappear {
            stopAudio() // Ensure audio stops when the view is dismissed
        }
    }
    
    // Prepares the audio player
    private func prepareAudioPlayer() {
        if let audioFilePath = Bundle.main.path(forResource: "Relax your mind from anywhere with this 3 minute guided meditation", ofType: "mp3") {
            let audioURL = URL(fileURLWithPath: audioFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error initializing audio player: \(error)")
            }
        } else {
            print("Audio file not found in the bundle.")
        }
    }
    
    // Toggles audio playback
    private func toggleAudio() {
        if isPlaying {
            stopAudio()
        } else {
            playAudio()
        }
    }
    
    // Starts audio playback and timer
    private func playAudio() {
        audioPlayer?.play()
        isPlaying = true
        startTimer()
    }
    
    // Stops audio playback and timer
    private func stopAudio() {
        audioPlayer?.stop()
        isPlaying = false
        currentTime = 0
        timer?.invalidate()
    }
    
    // Starts a timer to update the progress
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let player = audioPlayer {
                currentTime = player.currentTime
                if player.currentTime >= player.duration {
                    stopAudio()
                }
            }
        }
    }
}
