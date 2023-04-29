//
//  Player.swift
//  SQLiteTest
//
//  Created by Brayden M Dyke on 4/21/23.
//

import Foundation
  
class Player
{
    var number: Int = 0
    var name: String = ""
    var position: String = ""
    var year: String = ""
    var image: String = ""
    
    init(number:Int, name:String, position:String, year:String, image:String)
    {
        self.number = number
        self.name = name
        self.position = position
        self.year = year
        self.image = image
    }
}
