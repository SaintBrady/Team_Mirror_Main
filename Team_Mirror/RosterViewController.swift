//
//  RosterViewController.swift
//  Team_Mirror
//
//  Created by Brayden M Dyke on 4/28/23.
//

import UIKit

class RosterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var db = DBManager()
    var players = Array<Player>()

    var yearTypes = ["Freshman", "Sophomore", "Junior", "Senior"]
    var numbers = [1,2,3,4,5,6,7,8,10,12,13,14,15,17,18,19,22,23,24,25,26,27,28,30,31,32,33,34,35,36,39,40,41,43,44,45,46,52,53,54,55]
    var names = ["Phoenix Meza","Aidan Meola","Carson Benge","Zach Ehrhard","Jaxson Crull","Brennan Holt","Roc Riggio","Ian Daugherty","Nolan Schubart","Colin Brueggemann","Nolan McLean","Bayden Root","Noah Turley","Tyler Wulfert","Beau Sylvester","Marcus Brown","Gabe Davis","Juaron Watts-Brown","Ryan Ure","Evan O'Toole", "Derek Smith", "Brian Hendry", "Brennan Phillips", "Kade Shatwell", "David Mendham", "Drew Blake", "Chase Adkinson", "Isaac Stebens", "Dan Swirsky", "Brant Hogue", "Janzen Keisel", "Luke Fernandez", "Bowen Bridges", "Riley Taylor", "Cole Cosman", "Landry Kyle", "Dominick Reid", "Michael Benzor", "Ryan Bogusz", "Manning West", "Ben Abram"]
    var positions = ["Infielder","Infielder","Outfielder/Right-Handed Pitcher","Outfielder","Outfielder","Infielder/Outfielder","Infielder","Catcher","Outfielder/First Base","First Base","Outfielder/Infielder/Right-Handed Pitcher","Right-Handed Pitcher","First Base/Outfielder","Infielder/Outfielder","Catcher/First Base/Outfielder","Infielder","Right-Handed Pitcher","Right-Handed Pitcher","Left-Handed Pitcher","Right-Handed Pitcher", "Catcher", "Right-Handed Pitcher", "Left-Handed Pitcher", "Right-Handed Pitcher", "First Base/Infielder", "Left-Handed Pitcher", "Catcher", "Right-Handed Pitcher", "Infielder", "Left-Handed Pitcher", "Right-Handed Pitcher", "Right-Handed Pitcher", "Right-Handed Pitcher", "Right-Handed Pitcher", "Catcher", "Right-Handed Pitcher", "Right-Handed Pitcher", "Left-Handed Pitcher", "Right-Handed Pitcher", "Right-Handed Pitcher", "Right-Handed Pitcher"]
    var years = [0,1,0,1,2,0,1,1,0,1,2,3,2,2,0,2,0,1,1,2,0,2,0,0,3,0,2,2,0,2,1,0,0,2,1,2,0,0,2,1,3]
    var images = ["png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png", "png"]
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        db.deleteAllPlayers()
        for i in 0...40{
            db.insert(number: numbers[i], name: names[i], position: positions[i], year: yearTypes[years[i]], image: images[i])
        }
        players = db.read()
        
    }
}

extension RosterViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
  
extension RosterViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        
        let player = players[indexPath.row]
        
        cell.number?.text = String(player.number)
        cell.name?.text = player.name
        cell.position?.text = player.position
        cell.year?.text = player.year
        cell.picture?.image = UIImage(named: String(player.number))
        
        return cell
    }
}
