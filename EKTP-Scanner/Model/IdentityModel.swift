//
//  IdentityModel.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 20/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class IdentityModel: NSObject {
    var address: String?
    var addressSection: String?
    var bloodType: String?
    var birthDate: String?
    var district: String?
    var expiredDate: String?
    var faceImage: UIImage?
    var gender: String?
    var idNumber: String?
    var nationality: String?
    var maritalStatus: String?
    var name: String?
    var province: String?
    var religion: String?
    var village: String?
}

extension IdentityModel {
    func updateObject(data : [String : String]) {
        address = data[Constants.address]
        addressSection = data[Constants.addressSection]
        bloodType = data[Constants.bloodType]
        birthDate = data[Constants.birthDate]
        district = data[Constants.district]
        expiredDate = data[Constants.expiredDate]
        gender = data[Constants.gender]
        idNumber = data[Constants.idNumber]
        nationality = data[Constants.nationality]
        maritalStatus = data[Constants.maritalStatus]
        name = data[Constants.name]
        province = data[Constants.province]
        religion = data[Constants.religion]
        village = data[Constants.village]
    }
}
