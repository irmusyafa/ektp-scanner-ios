//
//  Utilities.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    public class func getDate(from str: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "GMT")
        formatter.dateFormat = "d MMM yyyy"
        return formatter.date(from: str) ?? Date()
    }
    
    public class func getString(from date: Date?) -> String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "GMT")
        formatter.dateFormat = "d MMM, yyyy"
        return formatter.string(from: date)
    }
    
    public class func getCurrentDate() -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "GMT")
        formatter.dateFormat = "d MMM, yyyy"
        
        let dateStr = formatter.string(from: Date())
        return formatter.date(from: dateStr) ?? Date()
    }
}
