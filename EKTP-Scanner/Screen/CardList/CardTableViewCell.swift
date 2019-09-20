//
//  CardTableViewCell.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var objectDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setup(_ object: CardModel?) {
        guard let object = object else { return }
        
        self.objectImage.image = object.image
        self.objectName.text = (object.person?.firstName ?? "") + " " + (object.person?.sureName ?? "")
        self.objectDate.text = Utility.getString(from: object.date ?? Date())
    }
    
}
