//
//  PersonDetailVC.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class PersonDetailVC: UIViewController {
    
    var viewModel: PersonDetailViewModel!
    
    // MARK: IBOutlets
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var nameView: ETSLabelTextFieldView!
    @IBOutlet weak var surnameView: ETSLabelTextFieldView!
    @IBOutlet weak var birthdateView: ETSLabelDatePickerView!
    @IBOutlet weak var emailView: ETSLabelTextFieldView!{
        didSet{
            emailView.textFieldKeyboardType = .emailAddress
        }
    }
    @IBOutlet weak var phoneView: ETSLabelPhoneTextFieldView!
    @IBOutlet weak var noteTextView: UITextView!{
        didSet{
            noteTextView.delegate = self
        }
    }
    @IBOutlet weak var noteMessageLabel: UILabel!{
        didSet{
            noteMessageLabel.isHidden = true
        }
    }
    @IBOutlet weak var saveUpdateButton: ETSGradientButton!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        addBorderTo(noteTextView)
        setPersonData()
    }
    
    func addBorderTo(_ view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setFont() {
        noteTextView.font = FontFace.regularFont(size: 14)
        saveUpdateButton.titleLabel?.font = FontFace.mediumFont(size: 19)
    }

    func setPersonData() {
        if viewModel.mode == .update {
            nameView.textField.text = viewModel.person?.name
            surnameView.textField.text = viewModel.person?.surname
            birthdateView.textField.text = viewModel.person?.birthdatTimeStamp?.convertToDateString()
            emailView.textField.text = viewModel.person?.email
            phoneView.textField.phoneNumber = viewModel.person?.phoneNumber
            noteTextView.text = viewModel.person?.note
        }
    }
}

extension PersonDetailVC{
    @IBAction func saveUpdateButtonTapped(_ sender: Any) {
        
        guard let name = nameView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            print("Warning: Name is empty!")
            nameView.showWarning()
            return
        }
        
        if !name.isValid(pattern: RegexPattern.namePattern){
            print("Invalid name. Chars length should be between 2 and 30")
            nameView.showWarning()
            return
        }
        
        guard let surname = surnameView.textField.text, !surname.isEmpty else {
            print("Warning: Surname is empty!")
            surnameView.showWarning()
            return
        }
        
        if !surname.isValid(pattern: RegexPattern.namePattern){
            print("Invalid surname. Chars length should be between 2 and 30")
            surnameView.showWarning()
            return
        }
        
        guard let birthdate = birthdateView.textField.text, !birthdate.isEmpty else {
            print("Warning: Birthdate is empty!")
            birthdateView.showWarning()
            return
        }
        
        guard let email = emailView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            print("Warning: Email is empty!")
            emailView.showWarning()
            return
        }
        
        if !email.isValid(pattern: RegexPattern.emailPattern){
            print("Invalid email. Should be max 60 chars")
            emailView.showWarning()
            return
        }
        
        guard let phoneNumber = phoneView.textField.getPhoneWithFormatE164(), !phoneNumber.isEmpty else {
            print("Warning: Phone number is empty!")
            phoneView.showWarning()
            return
        }
        
        let note = noteTextView.text ?? ""
        
        if !note.isValid(pattern: RegexPattern.notePattern){
            print("Note can be max 100 chars.")
            noteTextView.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1).cgColor
            noteMessageLabel.isHidden = false
            return
        }
        
        
        let updatedPerson = PersonData(
            id: UUID().uuidString,
            name: name,
            surname: surname,
            birthdatTimeStamp: birthdate.toTimeInterval(),
            email: email,
            phoneNumber: phoneNumber,
            note: note
        )
        
        viewModel.saveUpdate(person: updatedPerson) { [weak self] (success) in
            guard let self = self else { return }
            self.messageView.isHidden = false
            self.viewModel.show(mode: success ? .success("Kayıt Başarılı") : .error("Kayıt Başarısız")) {
                self.messageView.isHidden = true
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SegueMessageVC":
            viewModel.messageVC = segue.destination as? MessageVC
        default:
            break
        }
    }
}

extension PersonDetailVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        noteTextView.layer.borderColor = UIColor.clear.cgColor
        noteMessageLabel.isHidden = true
    }
}
