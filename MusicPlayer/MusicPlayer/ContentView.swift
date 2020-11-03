//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Antoine on 31/10/2020.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var ourData: OurData
    
    @State var currentAlbum: Album?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(ourData.albums) { album in
                            AlbumArt(album: album, displayName: true).onTapGesture {
                                currentAlbum = album
                            }
                        }
                    }
                }
                
                LazyVStack {
                    if ourData.albums.first != nil {
                        ForEach(currentAlbum?.songs ?? ourData.albums.first!.songs) { song in
                            SongCell(album: currentAlbum ?? ourData.albums.first!, song: song)
                        }
                    } else if ourData.isLoading {
                        DottedCircle().frame(width: 50, height: 50)
                    }
                }
            }
        }
    }
}

struct AlbumArt: View {
    var album: Album
    var displayName: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(album.image).resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 200, alignment: .center)
            if displayName {
                ZStack {
                    Rectangle().fill(Color.black).opacity(0.8)
                    Text(album.name).foregroundColor(.white)
                }.frame(height: 60, alignment: .center)
            }
        }.clipped()
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(20)
    }
}

struct SongCell: View {
    var album: Album
    var song: Song
    
    var body: some View {
        NavigationLink(destination: PlayerView(album: album, song: song)) {
            HStack {
                ZStack {
                    Circle().fill(Color.blue).frame(width: 50, height: 50)
                    Circle().fill(Color.white).frame(width: 20, height: 20)
                }
                Text(song.name).bold()
                Spacer()
                Text("\(song.duration)")
            }.padding(20)
        }.buttonStyle(PlainButtonStyle())
    }
}
