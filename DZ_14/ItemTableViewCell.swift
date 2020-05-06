//
//  ItemTableViewCell.swift
//  DZ_14
//
//  Created by Egor Malyshev on 28.04.2020.
//  Copyright © 2020 Egor Malyshev. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
