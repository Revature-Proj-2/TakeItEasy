//
//  DbHelperLite.swift
//  TakeItEasy
//
//  Created by xcode on 6/11/22.
//

import Foundation
import SQLite3
class DbHelperLite{

 
  
    
    static var dbHelper = DbHelperLite() //create a static  instance of DBHelper
    var dbpointer : OpaquePointer?
    var questions = [Questions]()
    
    //create DB
    
    @IBAction func viewData(_ sender: Any) {
        var question : [Questions]
      question = viewData1()
        print(question)
    }
    func createDB()
    {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Questions.sqlite")  // creates file path for db
        
        if sqlite3_open(filePath.path, &dbpointer) != SQLITE_OK{
            print("can not open db")
        }
        
    }
    
    func createTable(){
        if sqlite3_exec(dbpointer, "create table if not exists quiz (id integer primary key autoincrement, question text, correct_answer text, option_1 text, option_2 text, option_3 text, option_4 text)", nil, nil, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in table creation ", err)
        }
    }
    
    
    func insertData(question : NSString , correct_answer : NSString, option_1 : NSString, option_2 : NSString, option_3 : NSString, option_4 : NSString ){
        var stmt : OpaquePointer?
        let query = "insert into quiz (question, correct_answer, option_1, option_2, option_3, option_4) values (?,?,?,?,?,?)"
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in query creation ", err)
        }
        
        if sqlite3_bind_text(stmt, 1, question.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in saving question ", err)
        }
        
        if sqlite3_bind_text(stmt, 2, correct_answer.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in saving correct ", err)
        }
        if sqlite3_bind_text(stmt, 3, option_1.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in saving A ", err)
        }
        if sqlite3_bind_text(stmt, 4, option_2.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in saving B ", err)
        }
        if sqlite3_bind_text(stmt, 5, option_3.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in saving C ", err)
        }
        if sqlite3_bind_text(stmt, 6, option_4.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in saving D ", err)
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in table creation ", err)
        }
        
        print("data saved ")
    }
    
    
    func viewData1() -> [Questions]{
        questions.removeAll()
        let query = "select * from quiz"
        var stmt : OpaquePointer?
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{

        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let question = String(cString: sqlite3_column_text(stmt, 1))
            let correct_answer = String(cString: sqlite3_column_text(stmt, 2))
            let option_1 = String(cString: sqlite3_column_text(stmt, 3))
            let option_2 = String(cString: sqlite3_column_text(stmt, 4))
            let option_3 = String(cString: sqlite3_column_text(stmt, 5))
            let option_4 = String(cString: sqlite3_column_text(stmt, 6))
            
            questions.append(Questions(id: Int(id), correct_answer: correct_answer, option_1: option_1, option_2: option_2, option_3: option_3, option_4: option_4, question: question))
        
                             
        return questions
    }
                             
    
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in table creation ", err)
            return questions
    func getOneRecord(id : Int) -> Questions{
        let query = "select * from quiz where id = \(id);"
        var stmt : OpaquePointer?
        var quiz : Questions?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            
            while (sqlite3_step(stmt) == SQLITE_ROW){
                let id = sqlite3_column_int(stmt, 0)
                let question = String(cString: sqlite3_column_text(stmt, 1))
                let correct_answer = String(cString: sqlite3_column_text(stmt, 2))
                let option_1 = String(cString: sqlite3_column_text(stmt, 3))
                let option_2 = String(cString: sqlite3_column_text(stmt, 4))
                let option_3 = String(cString: sqlite3_column_text(stmt, 5))
                let option_4 = String(cString: sqlite3_column_text(stmt, 6))
                
                
                quiz = Questions(id: Int(id), correct_answer: correct_answer, option_1: option_1, option_2: option_2, option_3: option_3, option_4: option_4, question: question)
            }
        }
        else{
            print("error in query")
            
        }
        return quiz!
    }
    
        func updateRecord(id : Int, question: NSString){
        let query = "update quiz SET question = '\(question)' where id = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_int(stmt, 1, Int32(id))
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("data updated")
            }
            else{
                print("error in updation")
                
            }
        }
        else{
            print("error in query")
        }
        sqlite3_finalize(stmt)
    }
    
    func deleteById(id : Int){
        let query = "delete from quiz where id = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) ==  SQLITE_OK{
            sqlite3_bind_int(stmt, 1, Int32(id))
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("record deleted successfully")
            }
            else{
                print("can not delete record")
            }
        }else{
            print("problem in query")
        }
       
        
    }
    
    
    
}


}
