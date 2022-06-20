//
//  NotesViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var textIn: UITextView!
    @IBOutlet weak var notesTable: UITableView!
    @IBOutlet weak var notesCollection: UICollectionView!
    @IBOutlet weak var notesSearchBar: UISearchBar!
    @IBOutlet weak var displayArray: UISegmentedControl!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var micButton: UIButton!
    
    
    //Global Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let speechRecognizer = SpeechRecognizer()
    var notes = [Note]()
    var filteredNotes = [Note]()
    var user = [User]()
    let userDefault = UserDefaults.standard
    
    var filtered = false
    var noteIndex = -1
    var deleteIndexes = [Int]()
    var indexStore = [IndexPath]()
    var isDeleteMore = false

    
    //Create Buttons
    let saveNoteIcon: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.setTitle("Save", for: UIButton.State.normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        return button
    }()
    
    let updateNoteIcon: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.setTitle("Update", for: UIButton.State.normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        return button
    }()
    
    let deleteNoteIcon: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.setTitle("Delete", for: UIButton.State.normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        return button
    }()
    
    let trashIcon: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.setImage(UIImage(systemName: "trash"),for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let pressMicIcon: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.setImage(UIImage(systemName: "mic"),for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    
    //create objc for the buttons
    @objc func saveNote(){
        if(!isDeleteMore){
            if(textIn.hasText){
                createItem(text: textIn.text)
                getAllItems()
                reloadArray()
                noteIndex = notes.count - 1
            }
        }
    }
    
    @objc func updateNote(){
        if(!isDeleteMore){
            updateNoteIcon.backgroundColor = .blue
            if(noteIndex != notes.count && noteIndex != -1 && textIn.hasText){
                updateItem(item: notes[noteIndex], newText: textIn.text)
                getAllItems()
                reloadArray()
            }
        }
    }
    
    @objc func deleteNote(){
        if(isDeleteMore){
            for i in 0..<filteredNotes.count{
                if(filteredNotes[i].isChecked){
                    filteredNotes[i].isChecked = false
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
    
    @objc func deleteMore(){
        isDeleteMore = !isDeleteMore
        if(isDeleteMore){
            textIn.text = ""
            trashIcon.tintColor = .blue
            updateNoteIcon.backgroundColor = .gray
            saveNoteIcon.backgroundColor = .gray
        }else{
            trashIcon.tintColor = .gray
            updateNoteIcon.backgroundColor = .blue
            saveNoteIcon.backgroundColor = .blue
        }
        
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
    
    @objc func pressMic(){
        if(!isDeleteMore){
            speechRecognizer.startRecording(pressMicIcon)
        }
    }
    
    
    func setupViews(){

        // add a button
        view.addSubview(saveNoteIcon)
        view.addSubview(updateNoteIcon)
        view.addSubview(deleteNoteIcon)
        view.addSubview(trashIcon)
        view.addSubview(pressMicIcon)
        
        //set position
        saveNoteIcon.frame = CGRect(x: controlView.bounds.width / 8 - 25, y: controlView.bounds.height / 2 + 60, width: 88, height: 31)
        updateNoteIcon.frame = CGRect(x: controlView.bounds.width / 2 - 44, y: controlView.bounds.height / 2 + 60, width: 88, height: 31)
        deleteNoteIcon.frame = CGRect(x: controlView.bounds.width / 1.2 - 44, y: controlView.bounds.height / 2 + 60, width: 88, height: 31)
        trashIcon.frame = CGRect(x: controlView.bounds.minX + 14, y: controlView.bounds.minY + 170, width: 43, height: 31)
        pressMicIcon.frame = CGRect(x: controlView.bounds.minX + 14 + 30, y: controlView.bounds.minY + 170, width: 43, height: 31)

        // add the touchUpInside target
        saveNoteIcon.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        updateNoteIcon.addTarget(self, action: #selector(updateNote), for: .touchUpInside)
        deleteNoteIcon.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        trashIcon.addTarget(self, action: #selector(deleteMore), for: .touchUpInside)
        pressMicIcon.addTarget(self, action: #selector(pressMic), for: .touchUpInside)

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
        
        setUser()
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
        
        speechRecognizer.resultText = textIn
        speechRecognizer.startStopButton = micButton
        
        setupViews()
        notesTable.isHidden = true
    }
    
    //Core Data
    func setUser(){
            let userName = userDefault.string(forKey: "takeItEasyCurrentLoggedIn")
            do{
                let request = User.fetchRequest() as NSFetchRequest<User>
                let pred = NSPredicate(format: "userName == %@", userName!)
                request.predicate = pred
                let userArr = try context.fetch(request)
                user = userArr
            }catch{
                print("error getting items")
            }
        }
    
    
    
    func getAllItems(){
        notes = user.first?.note?.allObjects as! [Note]
        filteredNotes = notes
    }

    func createItem(text: String){
        let newItem = Note(context: context)
        newItem.text = text
        newItem.date = Date.now
        do{
            user.first?.addToNote(newItem)
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
        notesTable.deselectRow(at: indexPath, animated: true)
        
        if(!isDeleteMore){
            textIn.text = filteredNotes[indexPath.row].text
            noteIndex = indexPath.row
        }else{
            let cell = notesTable.cellForRow(at: indexPath) as! NotesTableViewCell
            cell.isChecked = !cell.isChecked
            filteredNotes[indexPath.row].isChecked = cell.isChecked
        }
    }
}

extension NotesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTable.dequeueReusableCell(withIdentifier: NotesTableViewCell.identefier) as! NotesTableViewCell
        
        cell.setupViews(isDeleteMore)
        cell.isChecked = filteredNotes[indexPath.row].isChecked
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
            }
            
            
        }else{
            cell.deleteBoxHidden()
        }
        
        return cell
    }
}
