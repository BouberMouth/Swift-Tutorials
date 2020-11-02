//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Antoine on 31/10/2020.
//

import SwiftUI
import Firebase
import AVFoundation

struct PlayerView: View {
    @State var album: Album
    @State var song: Song
    @State var isPlaying: Bool = true
    @State var player = AVPlayer()
    
    
    var body: some View {
        ZStack {
            Image(album.image)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .fill(Color.black)
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                AlbumArt(album: album, displayName: false)
                Text(song.name)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.light)
                Spacer()
                ZStack {
                    Color.white
                        .cornerRadius(20)
                        .shadow(radius: 10)
                    HStack {
                        Button(action: previous) {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                        }.frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.black)
                        .opacity(0.2)
                        
                        Button(action: playPause) {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                        }.frame(width: 70, height: 70, alignment: .center)
                        
                        Button(action: next) {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                        }.frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.black)
                        .opacity(0.2)
                    }
                }.frame(height: 150, alignment: .center)
                .padding(.horizontal, 30)
                .padding(.vertical, 90)
                
            }
            
        }.onAppear {
            changeSong()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                //print(player.currentItem?.currentTime().seconds)
            }
        }
    }
    
    func playPause() {
        isPlaying.toggle()
        if isPlaying {
            player.play()
        } else {
            player.pause()
        }
    }
    
    func next() {
        if let currentIndex = album.songs.firstIndex(of: song) {
            player.pause()
            if currentIndex != album.songs.count - 1 {
                song = album.songs[currentIndex + 1]
            } else {
                song = album.songs[0]
            }
            changeSong()
        }
    }
    
    func previous() {
        if let currentIndex = album.songs.firstIndex(of: song) {
            player.pause()
            if currentIndex != 0 {
                song = album.songs[currentIndex - 1]
            } else {
                song = album.songs[album.songs.count - 1]
            }
            changeSong()
        }
    }
    
    func changeSong() {
        let storage = Storage.storage().reference(forURL: song.file)
        storage.downloadURL { (url, error) in
            if let error = error {
                print(error)
            } else if let url = url {
                do {
                    try? AVAudioSession.sharedInstance().setCategory(.playback)
                }
                player = AVPlayer(url: url)
                if isPlaying {
                    player.play()
                }
            }
        }
    }
}
