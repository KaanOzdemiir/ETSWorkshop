//
//  PersonDetailVC.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import Foundation
import UIKit
import PhoneNumberKit

class PersonDetailVC: UIViewController {
    
    var viewModel: PersonDetailViewModel!
    
    lazy var pickerView: UIPickerView = {
        let p = UIPickerView()
        return p
    }()
    
    // MARK: IBOutlets
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTitleLabel: UILabel!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var birthdateTitleLabel: UILabel!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTitleLabel: UILabel!
    @IBOutlet weak var phoneTextField: PhoneNumberTextField!{
        didSet{
            phoneTextField.defaultRegion = "TR"
            phoneTextField.withPrefix = false
            phoneTextField.withFlag = true
            phoneTextField.delegate = self
        }
    }
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPersonData()
    }

    func setPersonData() {
        if viewModel.mode == .update {
            nameTextField.text = viewModel.person?.name
            surnameTextField.text = viewModel.person?.surname
            birthdateTextField.text = viewModel.person?.birthdatTimeStamp?.convertToDateString()
            emailTextField.text = viewModel.person?.email
            phoneTextField.text = viewModel.person?.phoneNumber
            noteTextView.text = viewModel.person?.note
        }
    }
}

extension PersonDetailVC{
    @IBAction func saveUpdateButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text, !name.isEmpty else {
            print("Warning: Name is empty!")
            return
        }
        
        if !name.isValid(pattern: RegexPattern.namePattern){
            print("Invalid name. Chars length should be between 2 and 30")
            return
        }
        
        guard let surname = surnameTextField.text, !surname.isEmpty else {
            print("Warning: Surname is empty!")
            return
        }
        
        if !surname.isValid(pattern: RegexPattern.namePattern){
            print("Invalid surname. Chars length should be between 2 and 30")
            return
        }
        
        guard let birthdate = birthdateTextField.text, !birthdate.isEmpty else {
            print("Warning: Birthdate is empty!")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            print("Warning: Email is empty!")
            return
        }
        
        if !email.isValid(pattern: RegexPattern.emailPattern){
            print("Invalid email. Should be max 60 chars")
            return
        }
        
        guard let phoneNumber = phoneTextField.text, let prefix = ((phoneTextField.leftView as? UIStackView)?.arrangedSubviews.first(where: {$0.tag == 999}) as? UILabel)?.text, !phoneNumber.isEmpty else {
            print("Warning: Phone number is empty!")
            return
        }
        
        
        guard let validPhoneNumber = viewModel.getPhoneNumber("\(prefix)\(phoneNumber)"), !validPhoneNumber.isEmpty else{
            print("Ivalid Phone number. Should be max 13 chars.")
            return
        }
        
        let note = noteTextView.text ?? ""
        
        
        let updatedPerson = PersonData(
            name: name,
            surname: surname,
            birthdatTimeStamp: nil,
            email: email,
            phoneNumber: validPhoneNumber,
            note: note
        )
        
        viewModel.saveUpdate(person: updatedPerson) { [weak self] (success) in
            guard let self = self else { return }
            if success{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PersonDetailVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case phoneTextField:
            let text = textField.text ?? ""
            
            if text.count > 12 && !string.isEmpty{
                return false
            }
        default:
            break
        }
        return true
    }
}
