//
//  BirthdateView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 1/30/21.
//

import UIKit

class GenderView: UIView {
    
    var chosenGenderStr: String = ""
    
    
    var viewTitle: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "What is your gender?"
        textLabel.font = .boldSystemFont(ofSize: 27.0)
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

        return textLabel
    }()
    
    
    
    
    var maleImageView: UIImageView = {
        var image = UIImage(named: "male")
        var imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    @objc
    func mImageTapped(recognizer: UITapGestureRecognizer) {
//        print("Male image tapped")
        
        femaleImageView.layer.masksToBounds = false
        femaleImageView.layer.borderWidth = 0.0
        femaleImageView.layer.borderColor = UIColor.clear.cgColor
        
        maleImageView.layer.masksToBounds = true
        maleImageView.layer.borderWidth = 1.5
        maleImageView.layer.borderColor = UIColor.white.cgColor
        
        chosenGenderStr = "Male"
    }
    
    
    var femaleImageView: UIImageView = {
        var image = UIImage(named: "female")
        var imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    @objc
    func fImageTapped(recognizer: UITapGestureRecognizer) {
//        print("Female image tapped")
        
        maleImageView.layer.masksToBounds = false
        maleImageView.layer.borderWidth = 0.0
        maleImageView.layer.borderColor = UIColor.clear.cgColor
        
        femaleImageView.layer.masksToBounds = true
        femaleImageView.layer.borderWidth = 1.5
        femaleImageView.layer.borderColor = UIColor.white.cgColor
        
        chosenGenderStr = "Female"
    }
    
    
    var genderImageContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
    
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(viewTitle)
        addSubview(genderImageContainer)
    }

    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//    func setupStackView() {
//        genderImageContainer.addSubview(maleBox)
//    }
    
    
    
    func setFrame(view: CGRect) {
        self.frame = view
        
        setViewTitle()
        setGenderImageContainer()
//        maleBox.heightAnchor.constraint(equalToConstant: 250).isActive = true
//        maleBox.widthAnchor.constraint(equalToConstant: self.frame.width * 0.45).isActive = true
//
//        let mIcon = UIImage(named: "male_symbol")
//        let maleImageView = UIImageView(image: mIcon)
//        maleImageView.translatesAutoresizingMaskIntoConstraints = false
////        maleImageView.heightAnchor.constraint(equalToConstant: genderImageContainer.frame.height * 0.70).isActive = true
//        maleImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        maleBox.addSubview(maleImageView)
//
//        let mLabel = UILabel()
//        mLabel.text = "Male"
//        mLabel.translatesAutoresizingMaskIntoConstraints = false
//        mLabel.topAnchor.constraint(equalTo: genderImageContainer.topAnchor, constant: 155)
//        mLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        maleBox.addSubview(mLabel)
    }
    
    
    func setGenderImageContainer() {
        genderImageContainer.translatesAutoresizingMaskIntoConstraints = false
        genderImageContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 240).isActive = true
        genderImageContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        genderImageContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17).isActive = true
        genderImageContainer.heightAnchor.constraint(equalToConstant: (self.frame.height * 0.26)).isActive = true
        genderImageContainer.spacing = 10.0
        
        genderImageContainer.addArrangedSubview(maleImageView)
//        maleImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        genderImageContainer.addArrangedSubview(femaleImageView)
//        femaleImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        maleImageView.isUserInteractionEnabled = true
        let mTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(mImageTapped))
        maleImageView.addGestureRecognizer(mTapRecognizer)
       
        femaleImageView.isUserInteractionEnabled = true
        let fTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(fImageTapped))
        femaleImageView.addGestureRecognizer(fTapRecognizer)
        
    }
    
    
    func setViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    
}
