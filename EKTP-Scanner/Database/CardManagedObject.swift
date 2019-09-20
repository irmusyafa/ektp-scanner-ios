//
//  CardManagedObject.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 20/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit
import CoreData

class CardManagedObject: NSManagedObject {
    @NSManaged public var id: NSNumber?
    @NSManaged public var cardImage: Data?
    @NSManaged public var date: Date?

    @NSManaged public var address: String?
    @NSManaged public var addressSection: String?
    @NSManaged public var bloodType: String?
    @NSManaged public var birthDate: String?
    @NSManaged public var district: String?
    @NSManaged public var expiredDate: String?
    @NSManaged public var faceImage: Data?
    @NSManaged public var gender: String?
    @NSManaged public var job: String?
    @NSManaged public var idNumber: String?
    @NSManaged public var nationality: String?
    @NSManaged public var maritalStatus: String?
    @NSManaged public var name: String?
    @NSManaged public var religion: String?
    @NSManaged public var province: String?
    @NSManaged public var village: String?
}

extension CardManagedObject {
    var object: CardModel {
        let identity = IdentityModel()
        identity.address = self.address
        identity.addressSection = self.addressSection
        identity.bloodType = self.bloodType
        identity.birthDate = self.birthDate
        identity.district = self.district
        identity.expiredDate = self.expiredDate
        if let img = self.faceImage { identity.faceImage = UIImage(data: img) }
        identity.gender = self.gender
        identity.job = self.job
        identity.idNumber = self.idNumber
        identity.nationality = self.nationality
        identity.maritalStatus = self.maritalStatus
        identity.name = self.name
        identity.province = self.province
        identity.religion = self.religion
        identity.village = self.village

        let object = CardModel()
        object.id = self.id?.intValue
        object.identity = identity
        object.date = self.date
        if let img = self.cardImage { object.image = UIImage(data: img) }
        
        return object
    }
    
    func updateObject(identity: IdentityModel, image: UIImage, date: Date) {
        self.address = identity.address
        self.addressSection = identity.addressSection
        self.bloodType = identity.bloodType
        self.birthDate = identity.birthDate
        self.district = identity.district
        self.date = date
        self.expiredDate = identity.expiredDate
        self.faceImage = image.pngData()
        self.gender = identity.gender
        self.job = identity.job
        self.idNumber = identity.idNumber
        self.nationality = identity.nationality
        self.maritalStatus = identity.maritalStatus
        self.name = identity.name
        self.province = identity.province
        self.religion = identity.religion
        self.village = identity.village
    }
}
