//
//  DbHelperLite.swift
//  TakeItEasy
//
//  Created by xcode on 6/11/22.
//

import Foundation
import SQLite3
class DbHelperLite{

 
    var dbHelper = DbHelperLite()
    var dbpointer : OpaquePointer?
    var questions = [Questions]()
    var quizlet = [Quizlet]()
    var quizzes = ["quiz1", "quiz2", "quiz3", "quiz4"]
    
    @IBAction func viewData(_ sender: Any) {
       
  
       
    }
    func createDB()
    {   for i in quizzes{
        if (quizzes.count <= 4){
    
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Questions\(i).sqlite")  // creates file path for db
     
        if sqlite3_open(filePath.path, &dbpointer) != SQLITE_OK{
            print("can not open db")
        }
        }else{
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Quizlet.sqlite")
            
        if sqlite3_open(filePath.path, &dbpointer) != SQLITE_OK{
                print("can not open db")
                
        }
        
        }
    }
        
        func createTable(){
            for i in quizzes{
                if (quizzes.count <= 4){
            
            if sqlite3_exec(dbpointer, "create table if not exists quiz\(i) (id integer primary key autoincrement, question text, correct_answer text, option_1 text, option_2 text, option_3 text, option_4 text)", nil, nil, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in table creation ", err)
            }
            if sqlite3_exec(dbpointer, "create table if not exists quizlet (id integer primary key autoincrement, prizePoints text, lastQuiz text, totalQuiz text)", nil, nil, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in table creation ", err)
            }
        }
            }
        }
        
        func insertData(question : NSString , correct_answer : NSString, option_1 : NSString, option_2 : NSString, option_3 : NSString, option_4 : NSString ){
            for i in quizzes{
                if (quizzes.count <= 4){
            var stmt : OpaquePointer?
            let query = "insert into quiz\(i) (question, correct_answer, option_1, option_2, option_3, option_4) values (?,?,?,?,?,?)"
            
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


        func insertData(prizePoints: NSString, lastQuiz: NSString, totalQuiz : NSString){
            
                   var stmt : OpaquePointer?
                   let query = "insert into quizlet (prizePoints, lastQuiz, totalQuiz) values (?,?,?)"
           
 
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in query creation ", err)
        }
            if sqlite3_bind_text(stmt, 1, prizePoints.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in saving question ", err)
            }
            
            if sqlite3_bind_text(stmt, 2, lastQuiz.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in saving correct ", err)
            }
            if sqlite3_bind_text(stmt, 3, totalQuiz.utf8String, -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in saving A ", err)
            }
          
        }
    
                
    func viewData() -> [Questions]{
        questions.removeAll()
        let query = "select * from quiz"
        var stmt : OpaquePointer?
                        
    if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{

                }
    while(sqlite3_step(stmt) == SQLITE_ROW){
    let id = sqlite3_column_int(stmt,0)
    let question = String(cString: sqlite3_column_text(stmt, 1))
    let correct_answer = String(cString: sqlite3_column_text(stmt, 2))
    let option_1 = String(cString: sqlite3_column_text(stmt, 3))
    let option_2 = String(cString: sqlite3_column_text(stmt, 4))
    let option_3 = String(cString: sqlite3_column_text(stmt, 5))
    let option_4 = String(cString: sqlite3_column_text(stmt, 6))



                          questions.append(Questions(id: Int(id), correct_answer: correct_answer, option_1: option_1, option_2: option_2, option_3: option_3, option_4: option_4 ))

                     
        return questions
           
                
    }
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in table creation ", err)
            return questions
            
        }
    func viewData() -> [Quizlet]{
            quizlet.removeAll()
            let query = "select * from quizlet"
            var stmt : OpaquePointer?
                            
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK{

                    }
        while(sqlite3_step(stmt) == SQLITE_ROW){
        let id = sqlite3_column_int(stmt,0)
        let prizePoints = String(cString: sqlite3_column_text(stmt, 1))
        let lastQuiz = String(cString: sqlite3_column_text(stmt, 2))
        let totalQuiz = String(cString: sqlite3_column_text(stmt, 3))


            quizlet.append(Quizlet(id: Int(id), prizePoints: prizePoints, totalQuiz: totalQuiz, lastQuiz: lastQuiz))

                         
            return quizlet
               
                    
        }
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in table creation ", err)
                return quizlet
                
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
    
    func updateRecord(id: Int, prizePoints: NSString){
    let query = "update quizlet SET prizePoints= '\(prizePoints)' where id = ?;"
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
}

}
