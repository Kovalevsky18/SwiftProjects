//
//  TableViewCell.swift
//  RealRacing
//
//  Created by Родион Ковалевский on 1/13/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    func setupCell(cell:TableViewCell,record:Record){
        cell.nameLabel.text = record.getName()
        cell.scoreLabel.text = String(record.getScore())
    }
}
