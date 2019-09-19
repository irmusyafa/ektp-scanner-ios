//
//  ScanView.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class ScanView: UIView {
    
    public func shape() {
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}
