//
//  CardDetailDataTableViewCell.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class CardDetailDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setup(title: String?, data: String?) {
        if let title = title { titleLabel.text = title }

        dataLabel.text = "-"
        if let data = data {
            dataLabel.text = data
        }
    }
}
