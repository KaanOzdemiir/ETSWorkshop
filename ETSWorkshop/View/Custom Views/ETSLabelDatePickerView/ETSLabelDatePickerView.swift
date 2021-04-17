//
//  ETSLabelDatePickerView.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import UIKit

class ETSLabelDatePickerView: UIView {

    // MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!{
        didSet{
            textField.inputView = datePickerView
            textField.delegate = self
        }
    }
    @IBOutlet weak var warningLabel: UILabel!{
        didSet{
            warningLabel.isHidden = true
        }
    }
    
    lazy var datePickerView: UIDatePicker = {
        let p = UIDatePicker()
        p.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(doneButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        
        textField?.inputAccessoryView = toolbar
        return p
    }()
    
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
    var textFieldKeyboardType: UIKeyboardType = .asciiCapable{
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
        self.containerView.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
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
        let nib = UINib(nibName: "ETSLabelDatePickerView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

}

extension ETSLabelDatePickerView{
    @objc func doneButtonClicked() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / yyyy"
        
        textField.text = formatter.string(from: datePickerView.date)
        self.endEditing(true)
    }
}


extension ETSLabelDatePickerView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.clear.cgColor
        warningLabel.isHidden = true
    }
}
