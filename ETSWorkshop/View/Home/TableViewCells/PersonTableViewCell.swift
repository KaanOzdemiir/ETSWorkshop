//
//  PersonTableViewCell.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import UIKit
import PhoneNumberKit

class PersonTableViewCell: UITableViewCell {

    static let cellIdentifier = "PersonTableViewCell"
    
    // MARK: IBOutlets
    @IBOutlet weak var detailContainerStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayTitleLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberTitleLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteContainerView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    
    let phoneNumberKit = PhoneNumberKit()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initViews()
        setFont()
        setBorders()
    }
    
    func setFont() {
        nameLabel.font = FontFace.mediumFont(size: 17)
        birthdayTitleLabel.font = FontFace.regularFont(size: 14)
        emailTitleLabel.font = FontFace.regularFont(size: 14)
        phoneNumberTitleLabel.font = FontFace.regularFont(size: 14)
        noteTitleLabel.font = FontFace.regularFont(size: 14)
        birthdayLabel.font = FontFace.mediumFont(size: 17)
        emailLabel.font = FontFace.mediumFont(size: 17)
        phoneNumberLabel.font = FontFace.mediumFont(size: 17)
        noteLabel.font = FontFace.mediumFont(size: 17)
    }
    
    func initViews() {
        detailContainerStackView.isHidden = true
    }
    
    func setBorders() {
        noteContainerView.layer.borderWidth = 1
        noteContainerView.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    }
    
    func setWith(_ person: PersonData) {
        detailContainerStackView.isHidden = person.isCollabsed
        
        nameLabel.text = [person.name ?? "", person.surname ?? ""].joined(separator: " ")
        birthdayLabel.text = person.birthdatTimeStamp?.convertToDateString()
        emailLabel.text = person.email
        set(person.phoneNumber)
        
        
        if !person.isCollabsed{
            noteLabel.text = person.note
        }
    }
    
    func set(_ phoneNumber: String?)  {
        DispatchQueue.main.async {
            do {
                let phoneNumber = try self.phoneNumberKit.parse(phoneNumber ?? "")
                self.phoneNumberLabel.text = self.phoneNumberKit.format(phoneNumber, toType: .international)
            }
            catch {
                print("Generic parser error")
                self.phoneNumberLabel.text = nil
            }
        }
        
    }
}
