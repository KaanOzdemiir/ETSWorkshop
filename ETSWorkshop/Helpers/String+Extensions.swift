//
//  String+Extensions.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import Foundation

extension String{
    
    func isValid(pattern: String) -> Bool {
        let nameRegex = NSPredicate(format:"SELF MATCHES %@", pattern)
        return nameRegex.evaluate(with: self)
    }
}
