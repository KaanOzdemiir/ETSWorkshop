//
//  TextField+Extentions.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 18.04.2021.
//

import Foundation
import UIKit

extension UITextField {
    func setupLeftImage(imageName:String){
       let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 16, height: 16))
       imageView.image = UIImage(named: imageName)
       let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
       imageContainerView.addSubview(imageView)
       leftView = imageContainerView
       leftViewMode = .always
     }
  }
