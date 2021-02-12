//
//  BirthdateView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 1/30/21.
//

import UIKit

class BirthdateView: UIView, UITextFieldDelegate {
    
    var birthdateStr: String = ""
    
    var viewTitle: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "When is your Birthday?"
        textLabel.font = .boldSystemFont(ofSize: 27.0)
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

        return textLabel
    }()
    
    
    var birthdateTextField: UITextField = {
        var textField = UITextField()
        
        textField.placeholder = "Enter your birthday"
        textField.font = .boldSystemFont(ofSize: 25)
        textField.textAlignment = .center
        textField.borderStyle = .line
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        
        
        return textField
    }()
    
    
    var datePicker = UIDatePicker()

    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        //create toolbar
        let toolbar = UIToolbar()
//        toolbar.sizeThatFits(CGSize(width: 100, height: 50))
        toolbar.sizeToFit()
        
        //bar button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        //assign toolbar
        birthdateTextField.inputAccessoryView = toolbar
        
        //assign date picker to the text field
        birthdateTextField.inputView = datePicker
    }
    
    @objc
    func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        birthdateTextField.text = formatter.string(from: datePicker.date)
        birthdateStr = (birthdateTextField.text)!
        birthdateTextField.textColor = .systemOrange
        birthdateTextField.font = .boldSystemFont(ofSize: 30)
        birthdateTextField.endEditing(true)
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(viewTitle)
        addSubview(birthdateTextField)
        birthdateTextField.delegate = self
        createDatePicker()
    }

    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setFrame(view: CGRect) {
        self.frame = view
        
        setViewTitle()
        setBirthdateTextField(view: view)
    }
    
    
    func setViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setBirthdateTextField(view: CGRect) {
        birthdateTextField.translatesAutoresizingMaskIntoConstraints = false
        birthdateTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 350).isActive = true
        birthdateTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        birthdateTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
    }
    
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (birthdateTextField.isEditing){
            birthdateTextField.endEditing(true)
            return true
        }

        return false;
    }
    
}
