//
//  ScheduleViewController.swift
//  Team_Mirror
//
//  Created by Brayden M Dyke on 4/28/23.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var db = GameDBManager()
    var games = Array<Game>()
    
    var ids = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51]
    var image1 = ["OSU","OSU","OSU","OSU","MISSOURI_STATE","OSU", "OSU", "OSU", "OSU", "OSU", "OSU", "OSU", "OSU", "OSU", "OSU", "TEXAS_TECH", "TEXAS_TECH", "TEXAS_TECH", "WICHITA_STATE", "OSU", "OSU", "OSU", "DBU", "OSU", "OSU", "OSU", "OSU", "TCU", "TCU", "TCU", "OSU", "OSU", "OSU", "OSU", "OSU", "KU", "KU", "KU", "OSU", "MICHIGAN", "MICHIGAN", "MICHIGAN", "ORU", "OSU", "OSU", "OSU", "OSU", "OSU", "OSU", "OU", "OU", "OU"]
    var scores = ["2 - 0", "1 - 0", "8 - 10", "11 - 1", "10 - 12", "19 - 2", "2 - 1", "12 - 4", "8 - 4", "7 - 4", "11 - 1", "10 - 4", "9 - 3", "9 - 4", "20 - 4", "8 - 7", "4 - 9", "12 - 1", "1 - 10", "11 - 9", "15 - 8", "13 - 2", "8 - 0", "3 - 5", "4 - 1", "4 - 3", "6 - 13", "6 - 7", "7 - 3", "12 - 5", "5 - 8", "3 - 6", "5 - 9", "11 - 6", "19 - 8", "10 - 15", "3 - 14", "3 - 8", "Canceled", "Postponed", "TBD", "TBD", "TBD", "TBD", "TBD", "TBD", "TBD", "TBD", "TBD", "TBD", "TBD", "TBD"]
    var dates = ["Feb 21 (Tue) - 4:00 PM", "Feb 25 (Sat) - 1:00 PM", "Feb 25 (Sat) - 4:00 PM", "Feb 26 (Sun) - 1:00 PM", "Feb 28 (Tue) - 3:00 PM", "Mar 3 (Fri) - 4:00 PM", "Mar 4 (Sat) - 1:00 PM", "Mar 5 (Sun) - 1:00 PM", "Mar 7 (Tue) - 3:00 PM", "Mar 8 (Wed) - 12:00 PM", "Mar 10 (Fri) - 6:00 PM", "Mar 11 (Sat) - 1:00 PM", "Mar 11 (Sat) - 6:00 PM", "Mar 12 (Sun) - 1:00 PM", "Mar 14 (Tue) - 6:00 PM", "Mar 17 (Fri) - 6:30 PM", "Mar 18 (Sat) - 2:00 PM", "Mar 19 (Sun) - 2:00 PM", "Mar 22 (Wed) - 6:00 PM", "Mar 24 (Fri) - 6:00 PM", "Mar 25 (Sat) - 6:00 PM", "Mar 26 (Sun) - 1:00 PM", "Mar 28 (Tue) - 6:30 PM", "Mar 31 (Fri) - 6:00 PM", "Apr 1 (Sat) - 6:00 PM", "Apr 2 (Sun) - 1:00 PM", "Apr 4 (Tue) - 6:00 PM", "Apr 6 (Thu) - 6:00 PM", "Apr 7 (Fri) - 8:00 PM", "Apr 8 (Sat) - 4:00 PM", "Apr 11 (Tue) - 6:00 PM", "Apr 14 (Fri) - 6:00 PM", "Apr 15 (Sat) - 6:00 PM", "Apr 16 (Sun) - 12:00 PM", "Apr 18 (Tue) - 6:00 PM", "Apr 21 (Fri) - 6:00 PM", "Apr 2 (Sat) - 2:00 PM", "Apr 23 (Sun) - 1:00 PM", "Apr 25 (Tue) - 6:00 PM", "Apr 28 (Fri) - 3:00 PM", "Apr 29 (Sat) - 1:00 PM", "Apr 30 (Sun) - 11:00 AM", "May 2 (Tue) - 6:00 PM", "May 5 (Fri) - 6:00 PM", "May 6 (Sat) - 6:00 PM", "May 7 (Sun) - 1:00 PM", "May 12 (Fri) - 6:00 PM", "May 13 (Sat) - 6:00 PM", "May 14 (Sun) - 1:00 PM", "May 18 (Thu) - 6:30 PM", "May 19 (Fri) - 6:30 PM", "May 20 (Sat) - 4:00 PM"]
    var image2 = ["CBU","LMU","LMU","LMU","OSU","AUSTIN_PEAY", "AUSTIN_PEAY", "AUSTIN_PEAY", "ARIZONA_STATE", "ARIZONA_STATE", "UTAH_TECH", "UTAH_TECH", "UTAH_TECH", "UTAH_TECH", "DBU", "OSU", "OSU", "OSU", "OSU", "BAYLOR", "BAYLOR", "BAYLOR", "OSU", "TEXAS", "TEXAS", "TEXAS", "WICHITA_STATE", "OSU", "OSU", "OSU", "ORU", "WV", "WV", "WV", "OU", "OSU", "OSU", "OSU", "WICHITA_STATE", "OSU", "OSU", "OSU", "OSU", "EAST_TENNESSEE", "EAST_TENNESSEE", "EAST_TENNESSEE", "KSTATE", "KSTATE", "KSTATE", "OSU", "OSU", "OSU"]
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        db.deleteAllGames()
        for i in ids {
            db.insert(id: ids[i], image1: image1[i], score: scores[i], date: dates[i], image2: image2[i])
        }
        games = db.read()
    }
}

extension ScheduleViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
  
extension ScheduleViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameCell
        
        let game = games[indexPath.row]
        
        cell.image1?.image = UIImage(named: game.image1)
        cell.score?.text = game.score
        cell.date?.text = game.date
        cell.image2?.image = UIImage(named: game.image2)
        return cell
    }
}
