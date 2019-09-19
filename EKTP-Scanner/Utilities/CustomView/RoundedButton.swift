//
//  RoundedButton.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shapeButton()
    }
    
    private func shapeButton() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15.0
    }
}
