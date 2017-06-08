//
//  MemberSettingTableViewCell.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 6. 8..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class MemberSettingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var role: UILabel!

    let items = ["first", "second", "third"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        role.text = "sample role"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
