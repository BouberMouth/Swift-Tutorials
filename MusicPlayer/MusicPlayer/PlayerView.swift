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
    @State var currentTime: Double = 0
    @State var duration: Double = 1
    
    
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
                ProgressionBar(elapsedTime: $currentTime, totalTime: $duration, player: $player)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 30)
                    .frame(height: 30)
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
                print(currentTime, duration)
                if currentTime >= duration && duration != 0 {
                    currentTime = 0
                    next()
                } else {
                    currentTime = player.currentItem?.currentTime().seconds ?? 0
                }
                

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
        duration = song.duration
        let storage = Storage.storage().reference(forURL: song.file)
        storage.downloadURL { (url, error) in
            if let error = error {
                print(error)
            } else if let url = url {
                do {
                    try? AVAudioSession.sharedInstance().setCategory(.playback)
                }
                player.replaceCurrentItem(with: AVPlayerItem(url: url))
                if isPlaying {
                    player.play()
                }
                print("-------")
            }
        }
    }
}


struct ProgressionBar: View {
    @Binding var elapsedTime: Double
    @Binding var totalTime: Double
    @Binding var player: AVPlayer

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill().opacity(0.3)
                    .frame(height: geo.size.height / 3)
                Capsule().fill()
                    .frame(width: widthForBarIn(geo.size),
                           height: geo.size.height / 3)
                Circle().fill()
                    .frame(width: geo.size.height, height: geo.size.height)
                    .offset(x: widthForBarIn(geo.size) - geo.size.height / 2)
                    .gesture(DragGesture()
                                .onEnded({ (value) in
                                    let newTime = elapsedTime + Double((value.translation.width * CGFloat(totalTime)) / geo.size.width)
                                    elapsedTime = max(min(newTime, totalTime), 0)
                                    player.seek(to: CMTime(seconds: elapsedTime, preferredTimescale: .max))
                                }))
            }
        }
    }
    
    func widthForBarIn(_ size: CGSize) -> CGFloat {
        size.width / CGFloat(totalTime) * CGFloat(elapsedTime)
    }
}
