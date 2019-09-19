//
//  CardScannerErrorViewController.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class CardScannerErrorViewController: UIViewController {
    @IBOutlet weak var captureImageView: UIImageView!
    public var capturedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateView()
    }
    
    private func initiateView() {
        self.captureImageView.image = capturedImage
    }
    
    @IBAction func retakeThePhoto(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
