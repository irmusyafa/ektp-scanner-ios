//
//  FullImageTableViewCell.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class FullImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userCard: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setup(_ item: CardModel) {
        if let card = item.image { self.userCard.image = card }
        userCard.layer.cornerRadius = 16
        userCard.layer.masksToBounds = true
    }
}
