//
//  Player.swift
//  SQLiteTest
//
//  Created by Brayden M Dyke on 4/21/23.
//

import Foundation
import UIKit
  
class Game
{
    var id: Int = 0
    var image1: String = ""
    var score: String = ""
    var date: String = ""
    var image2: String = ""
    
    init(id:Int, image1:String, score:String, date:String, image2:String)
    {
        self.id = id
        self.image1 = image1
        self.score = score
        self.date = date
        self.image2 = image2
    }
}
