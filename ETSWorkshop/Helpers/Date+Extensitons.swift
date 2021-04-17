//
//  Date+Extensitons.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import Foundation

extension TimeInterval{
    
    func convertToDateString(format: String = "dd / MM / yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: self))
        return dateString
    }
}
