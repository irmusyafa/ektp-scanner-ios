//
//  CardViewModel.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

typealias completionHandler = ((_ succeed: Bool) -> Void)

class CardViewModel: NSObject {
    override init() {
        super.init()
    }
    
    public func getCard() -> [CardModel] {
        return CardDatabase.getAllObjects().map({ $0.object })
    }
    
    public func deleteCard(id : NSNumber,
                           completionHandler: completionHandler) {
        if CardDatabase.deleteObject(id: id) {
            completionHandler(true)
            return
        }
        completionHandler(false)
    }
    
    public func addCard(data: [String:String],
                        image: UIImage,
                        faceImage: UIImage,
                        completionHandler: completionHandler) {

        let person = IdentityModel()
        person.updateObject(data: data)
        person.faceImage = image
        
        if CardDatabase.saveNewObject(identity: person, image: image, faceImage: faceImage) {
            completionHandler(true)
            return
        }
        completionHandler(false)
    }
    
    public func extractCardModel(cardModel : CardModel) -> [String?] {
        var extractedItems : [String?] = []
        extractedItems.append(cardModel.identity?.idNumber)
        extractedItems.append(cardModel.identity?.name)
        extractedItems.append(cardModel.identity?.gender)
        extractedItems.append(cardModel.identity?.address)
        extractedItems.append(cardModel.identity?.addressSection)
        extractedItems.append(cardModel.identity?.village)
        extractedItems.append(cardModel.identity?.district)
        extractedItems.append(cardModel.identity?.province)
        extractedItems.append(cardModel.identity?.religion)
        extractedItems.append(cardModel.identity?.maritalStatus)
        extractedItems.append(cardModel.identity?.job)
        extractedItems.append(cardModel.identity?.nationality)
        extractedItems.append(cardModel.identity?.expiredDate)
        return extractedItems
    }
    
    public var headers : [String] {
        return [
            Constants.idNumber,
            Constants.name,
            Constants.gender,
            Constants.address,
            Constants.addressSection,
            Constants.village,
            Constants.district,
            Constants.province,
            Constants.religion,
            Constants.maritalStatus,
            Constants.job,
            Constants.nationality,
            Constants.expiredDate
        ]
    }
}
