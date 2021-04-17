//
//  ETSLabelPhoneTextFieldView.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//
import UIKit
import PhoneNumberKit

class ETSLabelPhoneTextFieldView: UIView {

    // MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: PhoneNumberTextField!{
        didSet{
            textField.defaultRegion = "TR"
            textField.withPrefix = false
            textField.withFlag = true
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
        if text.count > 12 && !string.isEmpty{
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.clear.cgColor
        warningLabel.isHidden = true
    }
}
