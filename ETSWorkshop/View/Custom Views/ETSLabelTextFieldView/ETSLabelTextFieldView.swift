//
//  ETSLabelTextFieldView.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import UIKit

class ETSLabelTextFieldView: UIView {

    // MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!{
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
    
    var textFieldKeyboardType: UIKeyboardType = .asciiCapable{
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
        containerView.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1).cgColor
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
        let nib = UINib(nibName: "ETSLabelTextFieldView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

}

extension ETSLabelTextFieldView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.clear.cgColor
        warningLabel.isHidden = true
    }
}
