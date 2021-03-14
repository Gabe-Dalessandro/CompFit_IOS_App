//
//  ProfileInfoView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/4/21.
//

import UIKit

class ProfileInfoView: UIView {
    
    var profilePicture = UIImageView()
    var usernameLabel = UILabel()
    var userDescLabel = UILabel()
    var editProfileButton = UIButton()
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    


    func setView(superview: UIView, user: UserModel) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 17).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -17).isActive = true
        
        //Create the circular picture frame
        setProfilePicture()

        //Create the user name
        setUsername(username: user.email!)

        //Create user despcription
        setUserDesc(userDesc: (user.userDesc) ?? "test")
    }
    
    
    
    private func setProfilePicture() {
        self.addSubview(profilePicture)
        profilePicture.backgroundColor = .red
        profilePicture.layer.cornerRadius = 45
        profilePicture.contentMode = .scaleToFill
        profilePicture.clipsToBounds = true
        profilePicture.image = UIImage(named: "profile_test_image")
        
        
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0).isActive = true
        profilePicture.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setUsername(username: String) {
        self.addSubview(usernameLabel)
        usernameLabel.text = username
        usernameLabel.numberOfLines = 1
        usernameLabel.textColor = Constants.deepOrange
        usernameLabel.font = .boldSystemFont(ofSize: 22)

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.topAnchor.constraint(equalTo: profilePicture.topAnchor, constant: 25.0).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 17).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
 
    
    private func setUserDesc(userDesc: String){
        self.addSubview(userDescLabel)
        userDescLabel.numberOfLines = 0
        //userDescLabel.text = "Fitness Personality with @Compfit\n@theragun Athlete\nBoxing Professional for 9 years\nNo Excuses to get fit!"
        userDescLabel.text = userDesc
        userDescLabel.textColor = .systemTeal
        userDescLabel.font = .systemFont(ofSize: 15)
        
        
        userDescLabel.translatesAutoresizingMaskIntoConstraints = false
        userDescLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 20.0).isActive = true
        userDescLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        userDescLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
}




class EditProfileButton: UIButton {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setButton(superview: UIView, profileInfo: ProfileInfoView){
        superview.addSubview(self)
        self.setTitleColor(Constants.deepOrange, for: .normal)
        self.setTitle("Edit Profile", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 20)
        self.titleLabel?.textAlignment = .center

        self.layer.borderWidth = 2.0
        self.layer.borderColor = Constants.deepOrange.cgColor
        self.layer.cornerRadius = 8

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: profileInfo.userDescLabel.bottomAnchor, constant: 12).isActive = true
        self.leadingAnchor.constraint(equalTo: profileInfo.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: profileInfo.trailingAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

}





class InfoBoxes: UIView {
    
    var horizontalStackView = UIStackView()
    
    var workoutsButton = InfoButton()
    var followersButton = InfoButton()
    var followingButton = InfoButton()
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setInfoBoxes(superview: UIView, aboveView: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 15).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 17).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -17).isActive = true
        self.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 12
        
        addButtonsToStackView()
    }
    
    private func addButtonsToStackView() {
        horizontalStackView.addArrangedSubview(workoutsButton)
        horizontalStackView.addArrangedSubview(followersButton)
        horizontalStackView.addArrangedSubview(followingButton)
        
        workoutsButton.setButton(desc: "Workouts")
        followersButton.setButton(desc: "Followers")
        followingButton.setButton(desc: "Following")
    }
    

    

    
}


class InfoButton: UIButton {
    
    var dataLabel = UILabel()
    var label = UILabel()
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setButton(desc: String){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 3
        
        self.addSubview(dataLabel)
        dataLabel.textColor = .black
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        dataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        self.addSubview(label)
        label.text = desc
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    }
}





class SignOutButton: UIButton {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton(superview: UIView){
        superview.addSubview(self)
        self.setTitle("Sign Out", for: .normal)
        self.backgroundColor = Constants.deepOrange
        self.layer.cornerRadius = 15
        self.titleLabel?.font = .boldSystemFont(ofSize: 25)
        self.titleLabel?.textAlignment = .center
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -110).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 17).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -17).isActive = true
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
}
