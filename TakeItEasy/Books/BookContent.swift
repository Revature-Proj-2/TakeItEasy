//
//  BookContent.swift
//  TakeItEasy
//
//  Created by admin on 6/16/22.
//

import Foundation
import UIKit
import SwiftyJSON
import WebKit

class BookContent{
    
    var updateBooks : (()->())?
    var noResults : (()->())?
    var books = [Book]()
    var search = ""
    let json = JSON("{}")
    
    func setSearchbook(search: String){
        self.search = search
        for val in search{
            if(val == " "){
                let index = self.search.firstIndex(of: " ")!
                self.search.remove(at: index)
                self.search.insert("+", at: index)
            }
        }
        

    }
    
    func getSearchBook() -> String{
        return search
    }
    
    
    func run() {
        
        // any search query....
        //spaces must be replaced by +...
        
        let url = "https://www.googleapis.com/books/v1/volumes?q=" + getSearchBook()
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            guard let items = json["items"].array else{
                self.noResults?()
                return
            }
            for i in items{
                
                let id = i["id"].stringValue
                
                let title = i["volumeInfo"]["title"].stringValue
                guard let authors = i["volumeInfo"]["authors"].array else{
                    continue
                }
                
                var author = ""
                
                for j in authors{
                    
                    author += "\(j.stringValue)"
                }
                
                let description = i["volumeInfo"]["description"].stringValue
                
                guard let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].url else{
                    continue
                }
                print("got url")
                let imageData = try! Data(contentsOf: imurl)
                
                let url1 = i["volumeInfo"]["previewLink"].stringValue
                
                self.books.append(Book(id: JSON(id).string, title: JSON(title).string, desc: JSON(description).string, authors: JSON(author).string, imurl: imageData, url: JSON(url1).string))
                self.updateBooks?()
            }
        }.resume()
    }
}
struct Book{
 
        var id = JSON("").string
        var title = JSON("").string
        var desc = JSON("").string
        var authors = JSON("").string
        var imurl = Data()
        var url = JSON("").string
}
