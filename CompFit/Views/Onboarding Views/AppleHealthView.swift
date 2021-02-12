//
//  AppleHealthView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/2/21.
//

import UIKit

class AppleHealthView: UIView {
    
    var appleHealthStr: String = ""
    
    var viewTitle: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Sync with Apple Health"
        textLabel.font = .boldSystemFont(ofSize: 27.0)
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

        return textLabel
    }()
    
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.text = "To personalize your workouts and calculate your metrics, sync your Apple Health profile! Your data is kept secure and not sent or sold to anyone else."
        label.font = .systemFont(ofSize: 20.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    
    var syncButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sync with Apple Health", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(self, action: #selector(syncPressed), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc
    func syncPressed(sender : UIButton){
        sender.setTitle("Syncing ...", for: .normal)
//        print("sync button was pressed")
    }

    
    
    
//    var submitButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Submit", for: .normal)
//        button.backgroundColor = .systemOrange
//        button.layer.cornerRadius = 15
//        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
//        button.titleLabel?.textAlignment = .center
//
//        button.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
//
//        return button
//    }()
//
//
//    @objc
//    func submitPressed(sender : UIButton){
//        print("submit pressed")
//    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(viewTitle)
        addSubview(descLabel)
        addSubview(syncButton)
//        addSubview(submitButton)
    }

    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setFrame(view: CGRect) {
        self.frame = view
        
        setViewTitle()
        setDescLabel()
        setSyncButton()
//        setSubmitButton()
    }
    
    
    func setViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setDescLabel() {
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 17).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17).isActive = true
    }
    
    func setSyncButton() {
        syncButton.translatesAutoresizingMaskIntoConstraints = false
        syncButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 60).isActive = true
        syncButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        syncButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        syncButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
//    func setSubmitButton() {
//        submitButton.translatesAutoresizingMaskIntoConstraints = false
//        submitButton.topAnchor.constraint(equalTo: syncButton.bottomAnchor, constant: 260).isActive = true
//        submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17).isActive = true
//        submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17).isActive = true
//        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//    }
//
    
    
    
}
