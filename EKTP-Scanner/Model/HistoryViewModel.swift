//
//  HistoryViewModel.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

typealias personSavingCompletionHandler = ((_ succeed: Bool?) -> Void)

class HistoryViewModel: NSObject {
    override init() {
        super.init()
    }
    
    public func getHistory() -> [HistoryObject] {
        return HistoryDatabase.getAllObjects()
    }
    
    public func saveNewPerson(data: [String:String], image: UIImage, faceImage: UIImage, completionHandler: personSavingCompletionHandler) {
        let person = PersonObject()
        if let firstName = data["first name"] { person.firstName = firstName }
        if let surName = data["surname"] { person.sureName = surName }
        if let surnameBirth = data["surname at birth"] { person.sureNameBirthDate = surnameBirth }
        if let idNumber = data["id number"] { person.idNumber = idNumber }
        if let birthDate = data["date of birth"] { person.birthdate = Utility.getDate(from: birthDate) }
        if let gender = data["gender"] { person.gender = getGender(from: gender) }
        if let signature = data["signature"] { person.signature = signature }
        if let nationality = data["nationality"] { person.nationality = nationality }
        
        if HistoryDatabase.saveNewObject(object: person, image: image, faceImage: faceImage) {
            completionHandler(true)
            return
        }
        completionHandler(false)
    }
    
}

extension HistoryViewModel {
    private func getGender(from str: String) -> Gender {
        return Gender(rawValue: str.trimmingCharacters(in: .whitespacesAndNewlines)) ?? Gender.X
    }
}
