//
//  DBManager.swift
//  SQLiteTest
//
//  Created by Brayden M Dyke on 4/21/23.
//

import Foundation
import SQLite3
  
  
class DBManager
{
    init()
    {
        db = openDatabase()
        createTable()
    }
  
    let dbPath: String = "myDb.sqlite"
    var db: OpaquePointer?
  
    func openDatabase() -> OpaquePointer?
    {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
       {
           debugPrint("can't open database")
           return nil
       }
       else
       {
           print("Successfully created connection to database at \(dbPath)")
           return db
       }
    }
      
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS player(number INTEGER PRIMARY KEY, name TEXT, position TEXT, year TEXT, image TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("player table created.")
            } else {
                print("player table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
      
      
    func insert(number:Int, name:String, position:String, year: String, image:String)
    {
        let players = read()
        for p in players
        {
            if p.number == number
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO player (number, name, position, year, image) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(number))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (position as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (year as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (image as NSString).utf8String, -1, nil)
              
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
      
    func read() -> [Player] {
        let queryStatementString = "SELECT * FROM player;"
        var queryStatement: OpaquePointer? = nil
        var players : [Player] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let number = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let position = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let year = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let image = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                players.append(Player(number: Int(number), name: name, position: position, year: year, image: image))
                print("Query Result:")
                print("\(number) | \(name) | \(position) | \(year) | \(image)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return players
    }
      
    func deleteByID(number:Int) {
        let deleteStatementString = "DELETE FROM player WHERE number = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(number))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func deleteAllPlayers() {
        let deleteStatementString = "DELETE FROM player;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
