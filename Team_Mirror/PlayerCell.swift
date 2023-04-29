//
//  PlayerCell.swift
//  Team_Mirror
//
//  Created by Brayden M Dyke on 4/28/23.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet var number: UILabel?
    @IBOutlet var name: UILabel?
    @IBOutlet var position: UILabel?
    @IBOutlet var year: UILabel?
    @IBOutlet var picture: UIImageView?
}
