//
//  CircleButton.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    var stopRotate: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.shapeButton()
    }
    
    public func shapeButton() {
        self.backgroundColor = UIColor.clear
        self.stopRotate = false
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    public func rotateButton() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
            self.transform = self.transform.rotated(by: CGFloat(Double.pi))
        }) { (_) in
            if self.stopRotate { self.rotateButton() }
        }
    }
}
