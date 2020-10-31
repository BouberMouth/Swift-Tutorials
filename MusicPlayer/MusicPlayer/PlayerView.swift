//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Antoine on 31/10/2020.
//

import SwiftUI

struct PlayerView: View {
    var album: Album
    var song: Song
    @State var isPlaying: Bool = true
    
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
                }.edgesIgnoringSafeArea(.all)
                .frame(height: 200, alignment: .center)
            }
            
        }
    }
    
    func playPause() {
        isPlaying.toggle()
    }
    
    func next() {
        
    }
    
    func previous() {
        
    }
}
