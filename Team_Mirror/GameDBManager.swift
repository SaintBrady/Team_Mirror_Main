import Foundation
import SQLite3
  
  
class GameDBManager
{
    init()
    {
        db = openDatabase()
        createTable()
    }
  
    let dbPath: String = "GameDb.sqlite"
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
        let createTableString = "CREATE TABLE IF NOT EXISTS game(id INTEGER PRIMARY KEY, image1 TEXT, score TEXT, date TEXT, image2 TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("game table created.")
            } else {
                print("game table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
      
      
    func insert(id:Int, image1:String, score:String, date:String, image2:String)
    {
        let games = read()
        for g in games
        {
            if g.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO game (id, image1, score, date, image2) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (image1 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (score as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (image2 as NSString).utf8String, -1, nil)
              
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
      
    func read() -> [Game] {
        let queryStatementString = "SELECT * FROM game;"
        var queryStatement: OpaquePointer? = nil
        var games : [Game] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let image1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let score = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let image2 = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                games.append(Game(id: Int(id), image1: image1, score: score, date: date, image2: image2))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return games
    }
    
    func deleteAllGames() {
        let deleteStatementString = "DELETE FROM game;"
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
