//
//  UmbrellaUtil.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/13.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class UmbrellaUtil {
    
    enum OperationType: Int {
        case buyUmbrella = 1
        case rentUmbrella
        case returnUmbrella
    }
    
    enum MapMode {
        case locationsMode
        case rentalMode
    }
    
    static func transformStringToDate(stringDate: String) -> Date? {
        let isoDate = stringDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        if let date = dateFormatter.date(from: isoDate) {
            return date
        } else {
            return nil
        }
    }
}
