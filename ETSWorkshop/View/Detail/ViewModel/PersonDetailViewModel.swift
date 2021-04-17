//
//  PersonDetailViewModel.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import Foundation
import RxSwift
import PhoneNumberKit

// MARK: Screen modes
enum ScreenMode {
    case new
    case update
}

class PersonDetailViewModel {
    
    var person: PersonData?
    var mode: ScreenMode = .new
    let rxPersonUpdated = PublishSubject<(person: PersonData?, mode: ScreenMode)>()
    let phoneNumberKit = PhoneNumberKit()
    var messageVC: MessageVC?
    

    init(person: PersonData?, mode: ScreenMode) {
        self.person = person
        self.mode = mode
    }
    
    func saveUpdate(person: PersonData, complationHandler: @escaping (Bool) -> Void) {
        
        switch mode {
        case .new:
            self.person = person
        case .update:
            self.person = person
        }
        rxPersonUpdated.onNext((person: person, mode: mode))
        complationHandler(true)
    }
    
    func getPhoneNumber(_ number: String) -> String? {
        do {
            let phoneNumber = try phoneNumberKit.parse(number)
            return phoneNumberKit.format(phoneNumber, toType: .e164)
        }
        catch {
            print("Generic parser error")
        }
        return nil
    }
    
    func show(mode: MessageMode, duration: Double = 1.2, complationHandler: @escaping(() -> Void)) {
        switch mode {
        case .success(let message):
            messageVC?.messageLabel.text = message
            messageVC?.imageView.image = #imageLiteral(resourceName: "ic_thick")
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                complationHandler()
            }
        case .error(let error):
            messageVC?.messageLabel.text = error
            messageVC?.imageView.image = #imageLiteral(resourceName: "ic_cross").withRenderingMode(.alwaysTemplate)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                complationHandler()
            }
        case .unknown:
            complationHandler()
            break
        }
    }
}
