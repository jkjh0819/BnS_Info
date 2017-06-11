//
//  ConquestTableViewCell.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 6. 11..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class ConquestTableViewCell: UITableViewCell {

    @IBOutlet weak var conquestImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
