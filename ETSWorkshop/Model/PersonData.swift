//
//  PersonData.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 16.04.2021.
//

import Foundation

class PersonData {
    var id: String
    var name: String?
    var surname: String?
    var birthdatTimeStamp: TimeInterval?
    var email: String?
    var phoneNumber: String?
    var note: String?
    var isCollabsed: Bool = true
    
    init(
        id: String,
        name: String?,
        surname: String?,
        birthdatTimeStamp: TimeInterval?,
        email: String?,
        phoneNumber: String?,
        note: String?
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.birthdatTimeStamp = birthdatTimeStamp
        self.email = email
        self.phoneNumber = phoneNumber
        self.note = note
    }
}
