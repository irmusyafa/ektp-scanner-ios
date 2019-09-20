//
//  CardViewModel.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

typealias identitySavingCompletionHandler = ((_ succeed: Bool?) -> Void)

class CardViewModel: NSObject {
    override init() {
        super.init()
    }
    
    public func getCard() -> [CardModel] {
        return CardDatabase.getAllObjects()
    }
    
    public func saveNewPerson(data: [String:String], image: UIImage, faceImage: UIImage, completionHandler: identitySavingCompletionHandler) {

        let person = IdentityModel()
        if let firstName = data["first name"] { person.firstName = firstName }
        if let surName = data["surname"] { person.sureName = surName }
        if let surnameBirth = data["surname at birth"] { person.sureNameBirthDate = surnameBirth }
        if let idNumber = data["id number"] { person.idNumber = idNumber }
        if let birthDate = data["date of birth"] { person.birthdate = Utility.getDate(from: birthDate) }
        if let gender = data["gender"] { person.gender = getGender(from: gender) }
        if let signature = data["signature"] { person.signature = signature }
        if let nationality = data["nationality"] { person.nationality = nationality }
        
        if CardDatabase.saveNewObject(object: person, image: image, faceImage: faceImage) {
            completionHandler(true)
            return
        }
        completionHandler(false)
    }
    
    public func getHeaders() -> [String] {
        return [
            "Provinsi",
            "NIK",
            "Nama",
            "Jenis Kelamin",
            "Alamat",
            "Agama",
            "Kecamatan",
            "Status Perkawinan",
            "Kewarganegaraan",
            "Berlaku Hingga",
        ]
    }
}

extension CardViewModel {
    private func getGender(from str: String) -> Gender {
        return Gender(rawValue: str.trimmingCharacters(in: .whitespacesAndNewlines)) ?? Gender.X
    }
}
