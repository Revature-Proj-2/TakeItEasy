//
//  Structs.swift
//  TakeItEasy
//
//  Created by Conner Donnelly on 6/9/22.
//

import Foundation
import UIKit
struct Song{
    let title:String
    let artist:String
    let albumName:String
    let albumImageName:String
    let mediaSource:String
    let url:URL
}

struct CellViewModel{
    let title:String
    let artist:String
    let imageName:String
}

struct MusicPlayerViewModel{
    let title:String
    let artist:String
    let imageName:String
    let source:String
    let url:URL
}
