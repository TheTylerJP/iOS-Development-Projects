//
//  pokemonTableViewCell.swift
//  Pokemon List
//
//  Created by Tommy Bojanin on 2/19/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class pokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
