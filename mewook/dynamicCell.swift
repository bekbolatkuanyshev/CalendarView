//
//  dynamicCell.swift
//  mewook
//
//  Created by Бекболат Куанышев on 09.03.17.
//  Copyright © 2017 Bekbolat. All rights reserved.
//

import UIKit

class dynamicCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        startLabel.font = UIFont(name: "Rubic Light", size: 16.0)
        infoLabel.font = UIFont(name: "Rubic Light", size: 16.0)
        finishLabel.font = UIFont(name: "Rubic Light", size: 16.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
