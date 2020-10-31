//
//  Model.swift
//  MusicPlayer
//
//  Created by Antoine on 31/10/2020.
//

import Foundation

struct Song: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var duration: String
}

struct Album: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var songs: [Song]
    
    static var dummyData = [
        Album(name: "Album 1", image: "1", songs: [Song(name: "Song 11", duration: "6:66"),
                                                   Song(name: "Song 12", duration: "6:66"),
                                                   Song(name: "Song 13", duration: "6:66"),
                                                   Song(name: "Song 14", duration: "6:66")]
        ),
        Album(name: "Album 2", image: "2", songs: [Song(name: "Song 21", duration: "6:66"),
                                                   Song(name: "Song 22", duration: "6:66"),
                                                   Song(name: "Song 23", duration: "6:66"),
                                                   Song(name: "Song 24", duration: "6:66")]
        ),
        Album(name: "Album 3", image: "3", songs: [Song(name: "Song 31", duration: "6:66"),
                                                   Song(name: "Song 32", duration: "6:66"),
                                                   Song(name: "Song 33", duration: "6:66"),
                                                   Song(name: "Song 34", duration: "6:66")]
        ),
        Album(name: "Album 4", image: "4", songs: [Song(name: "Song 41", duration: "6:66"),
                                                   Song(name: "Song 42", duration: "6:66"),
                                                   Song(name: "Song 43", duration: "6:66"),
                                                   Song(name: "Song 44", duration: "6:66")]
        ),
        Album(name: "Album 5", image: "5", songs: [Song(name: "Song 51", duration: "6:66"),
                                                   Song(name: "Song 52", duration: "6:66"),
                                                   Song(name: "Song 53", duration: "6:66"),
                                                   Song(name: "Song 54", duration: "6:66")]
        ),
    ]
}

