//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/15/22.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var bookCollection1: UICollectionView!
    @IBOutlet weak var bookCollection2: UICollectionView!
    @IBOutlet weak var bookCollection3: UICollectionView!
    @IBOutlet weak var bookTable: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResults: UILabel!
    
    
    let bookContent1 = BookContent()
    let bookContent2 = BookContent()
    let bookContent3 = BookContent()
    
    var showResults = true
    var timer = Timer()
    var counter = 0
    
    var books1 = [Book]()
    var books2 = [Book]()
    var books3 = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("didload")
        // Do any additional setup after loading the view.
        bookCollection1.register(BookCollectionViewCell.nib(), forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        bookCollection2.register(BookCollectionViewCell.nib(), forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        bookCollection3.register(BookCollectionViewCell.nib(), forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        bookTable.register(BookSearchTableViewCell.nib(), forCellReuseIdentifier: BookSearchTableViewCell.identifier)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        bookCollection1.collectionViewLayout = layout
        bookCollection2.collectionViewLayout = layout
        bookCollection3.collectionViewLayout = layout
        
        bookCollection1.delegate = self
        bookCollection1.dataSource = self
        bookCollection2.delegate = self
        bookCollection2.dataSource = self
        bookCollection3.delegate = self
        bookCollection3.dataSource = self
        bookTable.delegate = self
        bookTable.dataSource = self
        searchBar.delegate = self
        
        bookTable.isHidden = true
        
        
        let date = Date.now.addingTimeInterval(0.2)
        timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(checkBook), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        
        bookContent1.setSearchbook(search: "Book")
        bookContent2.setSearchbook(search: "technical")
        bookContent3.setSearchbook(search: "cook books")
        bookContent1.run()
        bookContent2.run()
        bookContent3.run()
    }
    
    override func viewDidLayoutSubviews() {
        loadData()
        let date = Date.now.addingTimeInterval(0.2)
        bookContent1.updateBooks = {
            () in
            self.timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(self.checkBook), userInfo: nil, repeats: false)
            RunLoop.main.add(self.timer, forMode: .common)
            self.books1 = self.bookContent1.books
        }
        
        bookContent2.updateBooks = {
            () in
            self.timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(self.checkBook), userInfo: nil, repeats: false)
            self.books2 = self.bookContent2.books
        }
        
        bookContent3.updateBooks = {
            () in
            self.timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(self.checkBook), userInfo: nil, repeats: false)
            self.books3 = self.bookContent3.books
        }
        
        bookContent1.noResults = {
            ()in
            self.timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(self.checkBook), userInfo: nil, repeats: false)
            RunLoop.main.add(self.timer, forMode: .common)
            self.showResults = false
        }
    }
    
    @objc func checkBook(){
        
        if(!showResults){
            self.noResults.isHidden = false
            showResults = true
        }else{
            self.noResults.isHidden = true
        }
        
        loadData()
        timer.invalidate()
    }
    
    
    func loadData(){
        if(bookTable.isHidden){
        
        bookCollection1.reloadData()
        bookCollection2.reloadData()
        bookCollection3.reloadData()
        }else{
            bookTable.reloadData()
        }
    }
    
}

//filter
extension BooksViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBook(searchBar)
    }
    
    func searchBook(_ searchBar: UISearchBar){
        
        if(searchBar.text!.isEmpty){
            bookContent1.setSearchbook(search: "Book")
            bookTable.isHidden = true
            bookCollection1.isHidden = false
            bookCollection2.isHidden = false
            bookCollection3.isHidden = false
            bookContent2.run()
            bookContent3.run()
            loadData()
        }else{
            bookContent1.setSearchbook(search: searchBar.text!)
            bookTable.isHidden = false
            bookCollection1.isHidden = true
            bookCollection2.isHidden = true
            bookCollection3.isHidden = true
        }
        books1 = [Book]()
        bookContent1.books = [Book]()
        bookContent1.run()
        loadData()
    }
}

extension BooksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let book = books1[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Pdf") as! pdfViewController? else{
            return
        }
        vc.book = book.url!
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0;//Choose your custom row height
    }
}


extension BooksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTable.dequeueReusableCell(withIdentifier: BookSearchTableViewCell.identifier, for: indexPath) as! BookSearchTableViewCell
        
        cell.bookImage.image = UIImage(data: books1[indexPath.row].imurl)
        cell.bookAuthor.text = books1[indexPath.row].authors!
        cell.bookTitle.text = books1[indexPath.row].title!
        cell.bookDesc.text = books1[indexPath.row].desc!
        
        return cell
    }
}


extension BooksViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var book = Book()
        if(collectionView == bookCollection1){
            bookCollection1.deselectItem(at: indexPath, animated: true)
            book = books1[indexPath.row]
        }
        else if(collectionView == bookCollection2){
            bookCollection2.deselectItem(at: indexPath, animated: true)
            book = books2[indexPath.row]
        }
        else{
            bookCollection3.deselectItem(at: indexPath, animated: true)
            book = books3[indexPath.row]
        }
        
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Pdf") as! pdfViewController? else{
            return
        }
        vc.book = book.url!
        present(vc, animated: true, completion: nil)

    }
}
extension BooksViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 120, height: 180)
    }
}
extension BooksViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == bookCollection1){
            return books1.count
        }
        else if(collectionView == bookCollection2){
            return books2.count
        }
        else{
            return books3.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == bookCollection1){
            let cell = bookCollection1.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
            cell.bookImage.image = UIImage(data: books1[indexPath.row].imurl)
            cell.bookName.text = books1[indexPath.row].title
            return cell
        }
        else if(collectionView == bookCollection2){
            let cell = bookCollection2.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
            cell.bookImage.image = UIImage(data: books2[indexPath.row].imurl)
            cell.bookName.text = books2[indexPath.row].title
            return cell
        }
        let cell = bookCollection3.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        cell.bookImage.image = UIImage(data: books3[indexPath.row].imurl)
        cell.bookName.text = books3[indexPath.row].title

        return cell
    }
}
