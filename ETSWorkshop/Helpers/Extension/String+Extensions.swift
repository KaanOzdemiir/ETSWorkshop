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
    
    func toTimeInterval(format: String = "dd / MM / yyyy") -> TimeInterval? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)?.timeIntervalSince1970
    }
    
    func applyPatternOnNumbers(extarnalPattern: String? = nil, withoutPrefix: Bool = false) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        let pattern = extarnalPattern ?? getPhoneNumberPattern(withoutPrefix: withoutPrefix)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != "#" else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    func getPhoneNumberPattern(withoutPrefix: Bool) -> String {
        
        if self.contains("+90"){
            return withoutPrefix ? PhoneNumberFormat.trWithoutPrefix : PhoneNumberFormat.tr
        }
        
        if self.contains("+1"){
            return withoutPrefix ? PhoneNumberFormat.usWithoutPrefix : PhoneNumberFormat.us
        }
        return ""
    }
}
