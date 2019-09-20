//
//  CardModel.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit
import CoreData

class IdentityModel: NSObject {
    var idNumber:   String?
    var firstName:  String?
    var sureName:   String?
    var sureNameBirthDate: String?
    var birthdate:  Date?
    var gender:     Gender?
    var signature:  String?
    var nationality:String?
    var faceImage:  UIImage?
}

class CardModel: NSObject {
    var id:         Int?
    var person:     IdentityModel?
    var date:       Date?
    var image:      UIImage?
}

class CardManagedObject: NSManagedObject {
    @NSManaged var id:  NSNumber?
    @NSManaged var idNumber:   String?
    @NSManaged var firstName:  String?
    @NSManaged var sureName:   String?
    @NSManaged var sureNameBirthDate: String?
    @NSManaged var birthdate:  Date?
    @NSManaged var gender:     String?
    @NSManaged var signature:  String?
    @NSManaged var nationality: String?
    @NSManaged var date:       Date?
    @NSManaged var image:      Data?
    @NSManaged var faceImage:  Data?
}

extension CardManagedObject {
    var object: CardModel {
        let person = IdentityModel()
        person.idNumber = self.idNumber
        person.firstName = self.firstName
        person.sureName = self.sureName
        person.sureNameBirthDate = self.sureNameBirthDate
        person.birthdate = self.birthdate
        person.signature = self.signature
        person.nationality = self.nationality
        if let gndr = self.gender { person.gender = Gender(rawValue: gndr) }
        if let img = self.faceImage { person.faceImage = UIImage(data: img) }
        
        let object = CardModel()
        object.id = self.id?.intValue
        object.person = person
        object.date = self.date
        if let img = self.image { object.image = UIImage(data: img) }
        
        return object
    }
}

extension CardModel {
    var extractedItems : [String?] {
        var extractedItems : [String?] = []
        extractedItems.insert(person?.sureName, at: 0)
        extractedItems.insert(person?.firstName, at: 1)
        extractedItems.insert(person?.sureNameBirthDate, at: 2)
        extractedItems.insert(person?.idNumber, at: 3)
        extractedItems.insert(Utility.getString(from: person?.birthdate), at: 4)
        extractedItems.insert(person?.gender?.description, at: 5)
        extractedItems.insert(person?.signature, at: 6)
        extractedItems.insert(person?.nationality, at: 7)
        extractedItems.insert(Utility.getString(from: date), at: 8)
        return extractedItems
    }
}
enum Gender: String {
    case Male   = "M"
    case Female = "F"
    case X      = "X"
    
    var description: String {
        switch self {
        case .Male: return "Male"
        case .Female: return "Female"
        case .X: return "X"
        }
    }
}
