//
//  Sound.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import AVFoundation

enum Sound {
    private static var audioPlayer: AVAudioPlayer?

    /// Play completion sound effect
    static func playCompletion() {
        playSound(named: "completion-0")
    }

    /// Play a sound file by name
    static func playSound(named fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("Sound file not found: \(fileName).mp3")
            return
        }

        do {
            // Configure audio session for playback
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            // Create and play audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    /// Stop any currently playing sound
    static func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
