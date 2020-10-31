//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Antoine on 31/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    var albums = Album.dummyData
    @State var currentAlbum: Album?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(albums) { album in
                            AlbumArt(album: album).onTapGesture {
                                currentAlbum = album
                            }
                        }
                    }
                }
                
                LazyVStack {
                    ForEach(currentAlbum?.songs ?? albums.first!.songs) { song in
                        SongCell(song: song)
                    }
                }
            }
        }
    }
}

struct AlbumArt: View {
    var album: Album
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(album.image).resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 200, alignment: .center)
            ZStack {
                Rectangle().fill(Color.black).opacity(0.5)
                Text(album.name).foregroundColor(.white)
            }.frame(height: 60, alignment: .center)
        }.clipped()
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(20)
    }
}

struct SongCell: View {
    var song: Song
    
    var body: some View {
        HStack {
            ZStack {
                Circle().fill(Color.blue).frame(width: 50, height: 50)
                Circle().fill(Color.white).frame(width: 20, height: 20)
            }
            Text(song.name).bold()
            Spacer()
            Text(song.duration)
        }.padding(20)
    }
}
