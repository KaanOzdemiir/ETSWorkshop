//
//  RegexPatter.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import Foundation

struct RegexPattern {
    static let namePattern = "^[a-zA-Z0-9ğüşöçİĞÜŞÖÇ]+${2,20}"
    static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,60}"
    static let phoneNumberPattern = "[235689][0-9]{6}([0-9]{3})?"
}
