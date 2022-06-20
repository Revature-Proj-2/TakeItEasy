//
//  NotesViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit

class NotesViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var textIn: UITextView!
    @IBOutlet weak var notesTable: UITableView!
    @IBOutlet weak var notesCollection: UICollectionView!
    @IBOutlet weak var notesSearchBar: UISearchBar!
    @IBOutlet weak var displayArray: UISegmentedControl!
    
    
    //Global Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notes = [Note]()
    var filteredNotes = [Note]()
    var filtered = false
    var noteIndex = -1
    var deleteIndexes = [Int]()
    var indexStore = [IndexPath]()
    var isDeleteMore = false
    var deleteAllItems : (()->())?
    
    //IBActions
    @IBAction func saveNote(_ sender: Any){
        if(!isDeleteMore){
            if(textIn.hasText){
                createItem(text: textIn.text)
                getAllItems()
                reloadArray()
                noteIndex = notes.count - 1
            }
        }
    }
    
    @IBAction func updateNote(_ sender: Any){
        if(!isDeleteMore){
            if(noteIndex != notes.count && noteIndex != -1 && textIn.hasText){
                updateItem(item: notes[noteIndex], newText: textIn.text)
                getAllItems()
                reloadArray()
            }
        }
    }
    
    @IBAction func deleteNote(_ sender: Any){
        if(isDeleteMore){
            deleteAllItems?()
            for i in 0..<filteredNotes.count{
                if(filteredNotes[i].isChecked){
                    print("deleted")
                    filteredNotes[i].isChecked = false
                    print(i ,filteredNotes[i].isChecked)
                    deleteItem(item: filteredNotes[i])
                    deleteIndexes.append(i)
                    reloadArray()
                }
            }
        getAllItems()
        }else if(noteIndex != notes.count && noteIndex != -1){
            deleteItem(item: filteredNotes[noteIndex])
            getAllItems()
            if(noteIndex < filteredNotes.count){
                textIn.text = filteredNotes[noteIndex].text
            }else{
                textIn.text = ""
            }
        }
      
        reloadArray()
    }
    
    @IBAction func deleteMore(_ sender: Any){
        isDeleteMore = !isDeleteMore
        reloadArray()
    }
    
    @IBAction func changeArray(_ sender: Any){
        if(displayArray.selectedSegmentIndex == 0){
            notesTable.isHidden = true
            notesCollection.isHidden = false
        }else{
            notesCollection.isHidden = true
            notesTable.isHidden = false
        }
    }
    
    func reloadArray(){
        notesCollection.reloadData()
        notesTable.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        notesCollection.register(NotesCollectionViewCell.nib(), forCellWithReuseIdentifier: NotesCollectionViewCell.identifier)
        notesTable.register(NotesTableViewCell.nib(), forCellReuseIdentifier: NotesTableViewCell.identefier)
        
        getAllItems()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        notesCollection.collectionViewLayout = layout
        

        textIn.layer.cornerRadius = 20
        notesSearchBar.delegate = self
        notesTable.delegate = self
        notesTable.dataSource = self
        notesCollection.delegate = self
        notesCollection.dataSource = self
        
        
        notesTable.isHidden = true
    }
    
    //Core Data
    func getAllItems(){
        do{
        notes = try context.fetch(Note.fetchRequest())
        filteredNotes = notes
        
        }catch{
            print("Unable to find Items")
        }
    }

    func createItem(text: String){
        let newItem = Note(context: context)
        newItem.text = text
        newItem.date = Date.now
        do{
            try context.save()
        }
        catch{
            print("Unable to save context")
        }
    }
    
    func updateItem(item: Note, newText: String){
        item.text = newText
        item.date = Date.now
    }
    

    func deleteItem(item: Note){
        context.delete(item)
        do{
            try context.save()
        }
        catch{
            print("Unable to delete context")
        }
    }
    
}

//filter
extension NotesViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        filterContentForSearchText(searchText: searchText)
   }

   func filterContentForSearchText(searchText: String, scope: String = "All") {
       if searchText != "" {

           print(searchText)
           filteredNotes = notes.filter {name in

               return   name.text!.lowercased().contains(searchText.lowercased())

           }
       }else { self.filteredNotes = self.notes}
       reloadArray()
   }
    
}


//Table
extension NotesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        textIn.text = filteredNotes[indexPath.row].text
        noteIndex = indexPath.row
    }
}

extension NotesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTable.dequeueReusableCell(withIdentifier: NotesTableViewCell.identefier) as! NotesTableViewCell

        let note = filteredNotes[indexPath.row]
        cell.configure(with: note.text!, date: note.date!)
        return cell
    }
    
}


//Collection
extension NotesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        notesCollection.deselectItem(at: indexPath, animated: true)
        if(!isDeleteMore){
        textIn.text = filteredNotes[indexPath.row].text
        noteIndex = indexPath.row
        }
    }
    
    func store(){
    deleteAllItems = {
        () in
        print("erase")
        for val in self.indexStore{
            let cell = self.notesCollection.cellForItem(at: val) as! NotesCollectionViewCell
            cell.isChecked = false
        }
    }
    }
    
}

extension NotesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 120, height: 120)
    }
}

extension NotesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = notesCollection.dequeueReusableCell(withReuseIdentifier: NotesCollectionViewCell.identifier, for: indexPath) as! NotesCollectionViewCell
        self.indexStore.append(cell.cellIndex)
        let note = filteredNotes[indexPath.row]
        cell.configure(with: note.text!, date: note.date!, indexPath: indexPath)
        
        if(isDeleteMore){
            cell.deleteBox()
            
            cell.needsDeletion = {
                () in
                self.filteredNotes[indexPath.row].isChecked = cell.isChecked
                print(indexPath.row,cell.isChecked)
            }
            
            
        }else{
            cell.deleteBoxHidden()
        }
        
        return cell
    }
}
