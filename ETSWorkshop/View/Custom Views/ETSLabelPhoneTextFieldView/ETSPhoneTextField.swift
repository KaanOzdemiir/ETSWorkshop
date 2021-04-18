//
//  ETSPhoneTextField.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 18.04.2021.
//

import UIKit

class ETSPhoneTextField: UITextField {
    
    var phoneNumber: String?{
        didSet{
            if let splitedNumber = phoneNumber?.applyPatternOnNumbers().split(separator: " "){
                prefix = String(splitedNumber[0])
                self.text = splitedNumber.dropFirst().joined(separator: " ")
            }
        }
    }
    
    func getPhoneWithFormatE164() -> String? {
        switch prefix {
        case "+1":
            return phoneNumber?.applyPatternOnNumbers(extarnalPattern: "+###########")
        case "+90":
            return phoneNumber?.applyPatternOnNumbers(extarnalPattern: "+############")
        default:
            break
        }
        return nil
    }
    
    private let prefixTextField = UITextField()
    
    // Bu kısımlar regiona göre otomatik set edilebilir. İyileştirilebilir.
    private var prefixes = ["+90", "+1"]
    
    var selectedPrefix: String = "+90"

    lazy var countryPickerView: UIPickerView = {
        let p = UIPickerView()
        p.delegate = self
        p.dataSource = self
        return p
    }()
    
    var prefix: String = "" {
        didSet{
            prefixTextField.text = prefix
        }
    }
    
    @objc func doneButtonClicked() {
        prefix = selectedPrefix
        endEditing(true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardType = .numberPad
        configureLeftView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        keyboardType = .numberPad
        configureLeftView()
    }
    
    
    func configureLeftView() {
        
        let stackView = UIStackView(frame: .init(x: 0, y: 0, width: 50, height: 20))
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        prefixTextField.borderStyle = .none
        prefixTextField.textColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        prefixTextField.tag = 999
        prefixTextField.inputView = countryPickerView
        prefixTextField.tintColor = UIColor.clear
        prefix = selectedPrefix
        
        prefixTextField.inputAccessoryView = prepareToolbar()
        
        let downArrowImageView = UIImageView()
        downArrowImageView.contentMode = .scaleAspectFit
        downArrowImageView.image = #imageLiteral(resourceName: "ic_down_chevron")
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.widthAnchor.constraint(equalToConstant: 0).isActive = true
        spacer.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        stackView.addArrangedSubview(prefixTextField)
        stackView.addArrangedSubview(downArrowImageView)
        stackView.addArrangedSubview(seperatorView)
        stackView.addArrangedSubview(spacer)
                
        leftView = stackView
        leftViewMode = .always
    }
    
    func prepareToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(doneButtonClicked))
        toolbar.setItems([flexButton, doneButton], animated: true)
        toolbar.sizeToFit()
        return toolbar
    }
}

extension ETSPhoneTextField: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let prefix = prefixes[row]
        return prefix
    }
}

extension ETSPhoneTextField: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPrefix = prefixes[row]
    }
}
