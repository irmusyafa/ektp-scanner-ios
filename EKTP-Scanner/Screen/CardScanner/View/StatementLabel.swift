//
//  StatementLabel.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class StatementLabel: UILabel {
    
    public func shape(_ txt: String, font: UIFont) {
        self.font = font
        self.text = txt
        self.textColor = UIColor.white
        self.textAlignment = .center
    }
    
}
