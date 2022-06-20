//
//  Structs.swift
//  TakeItEasy
//
//  Created by Conner Donnelly on 6/9/22.
//

import Foundation
import UIKit
struct Album : Codable {
    var title : String
    var cover : String
    var artist : Artist
    var tracks : Tracks
}

struct Artist : Codable {
    var name : String
}

struct Tracks : Codable {
    var data : [Songs]
}

struct Songs : Codable {
    var title : String
    var preview : String
}

struct CellViewModel{
    let title:String
//    let artist:String
    let image:String
}

struct MusicPlayerViewModel{
    let title:String
    let artist:String
    let image:String
    let album:String
    let url:String
}
