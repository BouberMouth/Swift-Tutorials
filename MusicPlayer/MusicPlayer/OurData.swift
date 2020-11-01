//
//  Data.swift
//  MusicPlayer
//
//  Created by Antoine on 01/11/2020.
//

import SwiftUI
import Firebase

class OurData: ObservableObject {
    
    @Published public var albums = [Album]()
    @Published public var isLoading: Bool = false
    
    func loadData() {
        isLoading = true
        Firestore.firestore().collection("albums").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let snapshot = snapshot {
                var decodedAlbums = [Album]()
                
                for document in snapshot.documents {
                    let albumName = document.data()["name"] as? String ?? "error"
                    let albumImage = document.data()["image"] as? String ?? "error"
                    
                    let songs = document.data()["songs"] as? [String : [String : Any]] ?? [String : [String : Any]]()
                    
                    var decodedSongs = [Song]()
                    
                    for song in songs {
                        let songName = song.value["name"] as? String ?? "error"
                        let songDuration = song.value["duration"] as? String ?? "error"
                        let songFile = song.value["file"] as? String ?? "error"
                        
                        decodedSongs.append(Song(name: songName, duration: songDuration, file: songFile))
                    }
                    
                    decodedAlbums.append(Album(name: albumName,
                                               image: albumImage,
                                               songs: decodedSongs))
                }
                
                self.albums = decodedAlbums
                self.isLoading = false
            }
        }
        
    }
}
