//
//  CustomTextField.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/30/21.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
        backgroundColor = .secondarySystemBackground
        autocapitalizationType = .none
        font = UIFont.poppinsLight(size: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
