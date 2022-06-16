//
//  Structs.swift
//  TakeItEasy
//
//  Created by Conner Donnelly on 6/9/22.
//

import Foundation
import UIKit
//struct Song:Codable{
//    let title:String
//    let preview:String
//    let artist:Artist
//    let albumName:Album
//    let albumImage:Album
//}
//struct Artist:Codable{
//    let artist:String
//}
//
//struct Album:Codable{
//    let name:String
//    let image:UIImage
//}
//
//struct Songs:Codable{
//    var songs:[Song]
//}

//struct Album:Codable{
//    let title:String
//    let cover:String
//    let artist:Artist
//}
//struct Artist:Codable{
//    let name:String
//}
//struct Tracks:Codable{
//    let track:[Track]
//}
//s
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
