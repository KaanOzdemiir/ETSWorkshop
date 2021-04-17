//
//  PersonTableViewCell.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    static let cellIdentifier = "PersonTableViewCell"
    
    // MARK: IBOutlets
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setBorders()
    }
    
    func setBorders() {
        noteContainerView.layer.borderWidth = 1
        noteContainerView.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    }
    
    func setWith(_ person: PersonData) {
        nameLabel.text = [person.name ?? "", person.surname ?? ""].joined(separator: " ")
        birthdayLabel.text = "\(person.birthdatTimeStamp!)"
        emailLabel.text = person.email
        phoneNumberLabel.text = person.phoneNumber
    }
}
