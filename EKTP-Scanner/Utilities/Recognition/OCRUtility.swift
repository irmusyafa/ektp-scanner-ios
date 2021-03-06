//
//  OCRUtility.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMLVision

typealias textDetectionCompletion = ((_ error: Error?, _ blocks: [String]?) -> Void)

class OCRUtility: NSObject {
    private lazy var vision = Vision.vision()
    private var textRecognizer: VisionTextRecognizer!
    private let metadata = VisionImageMetadata()
    private let tolerance: CGFloat = 5

    override init() {
        super.init()
    }
    
    func detectText(image: UIImage, _ completion: @escaping textDetectionCompletion) {
        textRecognizer = vision.onDeviceTextRecognizer()
        let visionImage = VisionImage(image: image)
        
        textRecognizer.process(visionImage) { [weak self] result, error in
            guard let ws = self else { return }
            if let error = error {
                completion(error, nil);
            }
            
            if let blocks = result?.blocks {
                completion(nil, ws.reBlocksData(blocks: blocks))
            }
        }
    }
    
    private func reBlocksData(blocks: [VisionTextBlock]) -> [String] {
        var newBlocks : [String] = []
        var lines : [VisionTextLine] = []
        var groupLines : [[VisionTextLine]] = []
        
        for block in blocks {
            for line in block.lines {
                lines.append(line)
            }
        }
        
        var lineUsed : [VisionTextLine] = []
        for line in lines {
            var linesSomeVerticalPosition : [VisionTextLine] = []
            
            for searchLine in lines {
                if equalPositionWithTolerance(a: line.frame.minY, b: searchLine.frame.minY, tolerance: tolerance),
                    !linesSomeVerticalPosition.contains(searchLine){
                    linesSomeVerticalPosition.append(searchLine)
                    lineUsed.append(searchLine)
                }
            }

            linesSomeVerticalPosition = linesSomeVerticalPosition.sorted(by: { $0.frame.minX < $1.frame.minX })
            groupLines.append(linesSomeVerticalPosition)
        }
        
        for groupLine in groupLines {
            var text = ""
            for line in groupLine {
                text.append(line.text)
            }
            newBlocks.append(text)
        }
        
        newBlocks = Array(Set(newBlocks))
        print(newBlocks)
        return newBlocks
    }
    
    private func equalPositionWithTolerance(a : CGFloat, b : CGFloat, tolerance : CGFloat) -> Bool {
        if a >= b && a <= b + tolerance {
            return true
        }
        
        if b >= a && b <= a + tolerance {
            return true
        }
        
        return false
    }
}
