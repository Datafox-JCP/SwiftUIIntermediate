//
//  SoundView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 03/06/23.
//

import SwiftUI
// 4
import AVKit

// 2
class SoundManager {
    // 3 crear un singleton
    static let instance = SoundManager()
    // 5
    var player: AVAudioPlayer?
    
    // 8
    enum SoundOption: String {
        case knock = "DoorKnock"
        case thunder = "ThunderWindRain"
    }
    
    // 9 modificar
//    func playSound() {
    func playSound(sound: SoundOption) {
        
//        guard let url = URL(string: "") else { return }
        // 6
//        guard let url = Bundle.main.url(forResource: "DoorKnock", withExtension: ".mp3") else { return }
        // 11 queda así
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct SoundView: View {
    
    // 1
    var body: some View {
        VStack {
            Button("Reproducir primer sonido") {
                // 7
                SoundManager.instance.playSound(sound: .knock)
            }
            
            Button("Reproducir segundo sonido") {
                SoundManager.instance.playSound(sound: .thunder)
            }
        }
        .buttonStyle(.bordered)
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SoundView()
    }
}
