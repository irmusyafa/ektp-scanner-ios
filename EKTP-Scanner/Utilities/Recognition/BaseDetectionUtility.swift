//
//  BaseDetectionUtility.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit
import CoreML
import Vision

class BaseDetectionUtility: NSObject {
    internal var inputImage: CIImage!
    internal let queueTarget = DispatchQueue(label: "detection_queue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
    
    override init() {
        super.init()
    }
    
    public func detect(_ liveImage: CIImage) { }
    
    internal func handleRequest(request: VNRequest, error: Error?) { }
}
