//
//  ETSLabelPhoneTextFieldView.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//
import UIKit
//import PhoneNumberKit

class ETSLabelPhoneTextFieldView: UIView {

    // MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: ETSPhoneTextField!{
        didSet{
            textField.delegate = self
        }
    }
    @IBOutlet weak var warningLabel: UILabel!{
        didSet{
            warningLabel.isHidden = true
        }
    }
    
    @IBInspectable
    var titleText: String?{
        didSet{
            titleLabel.text = titleText
        }
    }
    
    @IBInspectable
    var warningText: String?{
        didSet{
            warningLabel.text = warningText
        }
    }
    
    @IBInspectable
    var textFieldKeyboardType: UIKeyboardType = .phonePad{
        didSet{
            textField.keyboardType = textFieldKeyboardType
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBorders()
        setFont()
        addTapGesture()
    }
    
    func addTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func viewTapped(_ gesture: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    func showWarning() {
        containerView.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
        self.warningLabel.isHidden = false
    }
    
    func setBorders() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setFont() {
        titleLabel.font = FontFace.regularFont(size: 14)
        textField.font = FontFace.mediumFont(size: 17)
        warningLabel.font = FontFace.regularFont(size: 14)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
        setBorders()
        addTapGesture()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "ETSLabelPhoneTextFieldView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

}

extension ETSLabelPhoneTextFieldView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""

        switch self.textField.prefix {
        case "+1":
            if string.isEmpty{
                self.textField.phoneNumber = "+1\(text)".applyPatternOnNumbers()
                return true
            }
            if "\(text)\(string)".count > 20{
                return false
            }
            
            self.textField.phoneNumber = "+1\(text)\(string)".applyPatternOnNumbers()
            return false
        case "+90":
            if string.isEmpty{
                self.textField.phoneNumber = "+90\(text)".applyPatternOnNumbers()
                return true
            }
            if "\(text)\(string)".count > 13{
                return false
            }
            
            self.textField.phoneNumber = "+90\(text)\(string)".applyPatternOnNumbers()
            return false
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.clear.cgColor
        warningLabel.isHidden = true
    }
}
