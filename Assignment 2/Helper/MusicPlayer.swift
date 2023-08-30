/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 29/08/2023
  Last modified: 02/09/2023
  Acknowledgement: 
    https://www.zerotoappstore.com/how-to-add-background-music-in-swift.html
*/

import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?

    func startBackgroundMusic(backgroundMusicFileName: String) {
      if let bundle = Bundle.main.path(forResource: backgroundMusicFileName, ofType: "mp3") {
          let backgroundMusic = NSURL(fileURLWithPath: bundle)
          do {
              audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
              guard let audioPlayer = audioPlayer else { return }
              audioPlayer.numberOfLoops = -1
              audioPlayer.prepareToPlay()
              audioPlayer.play()
          } catch {
              print(error)
          }
      }
  }

  func playSoundEffect(soundEffect: String) {
    if let bundle = Bundle.main.path(forResource: soundEffect, ofType: "mp3") {
        let soundEffectUrl = NSURL(fileURLWithPath: bundle)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:soundEffectUrl as URL)
            guard let audioPlayer = audioPlayer else { return }
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
  }
  
  func stopBackgroundMusic() {
      guard let audioPlayer = audioPlayer else { return }
      audioPlayer.stop()
  }
    
}
