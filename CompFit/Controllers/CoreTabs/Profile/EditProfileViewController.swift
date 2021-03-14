//
//  EditProfileController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/12/21.
//

import UIKit


//Used for the various fields that can be editted within this contorller
struct EditProfileFormModel {
    let formFieldLabel: String
    let placeholder: String
    var inputValue: String? //will hold the value of what the user types
}


class EditProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    let userdata = Constants.currentUser
    let userProfilePicture: UIImageView
    let updateProfilePictureURL: URL = URL(string: HTTPRequests.update_profile_picture)!
    
    let editTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        
        return tableView
    }()
    
    //The Controller will have 2 secitons: Therefore user a 2D array
    private var models = [[EditProfileFormModel]]()
    
    init() {
        self.userProfilePicture = UIImageView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        self.title = "Edit Profile"
    }
    
    
    init(reference_to_profile_pic profilePictureImageViewReference: UIImageView) {
        self.userProfilePicture = profilePictureImageViewReference
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        editTableView.delegate = self
        configureFormModels()
        editTableView.tableHeaderView = createTableHeaderView()
        
        editTableView.dataSource = self
        view.addSubview(editTableView)
        
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didTapCancel))
        
//        addChooseFromLibraryButton()
//        addUseCameraButton()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        editTableView.frame = view.bounds
    }
    
    
    private func configureFormModels() {
        //Name, username, website, bio
        let section1Labels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            //input value: should query from the DB and use the current value
            let model = EditProfileFormModel(formFieldLabel: label, placeholder: "Enter \(label)...", inputValue: nil)
            section1.append(model)
        }
        models.append(section1)
        
        
        //Email, phone, gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            //input value: should query from the DB and use the current value
            let model = EditProfileFormModel(formFieldLabel: label, placeholder: "Enter \(label)...", inputValue: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    
    
    //The TableView Header is displayed right above the first cell in the table view
    private func createTableHeaderView() -> UIView {
        //Create the view that will be the header of the table view
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/4).integral)
        let size = header.frame.height/1.5
        
        //Create the button that will display the user's profile picture
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.frame.width-size)/2, y: (header.frame.height-size)/2, width: size, height: size))
        
        //Add the picture to the header view and edit it
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
    @objc private func didTapProfileButton() {
        
    }
    
    @objc private func didTapCancel(){
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
    
    //Will save info to the database
    @objc private func didTapSave(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapChangeProfile() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Used for Ipad so it won't crash
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func addUseCameraButton() {
        
        let button = UIButton()
        button.setTitle("Use Camera", for: .normal)
        button.backgroundColor = Constants.deepOrange
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(self, action: #selector(useCamera), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -110).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    @objc
    func useCamera(sender : UIButton) {
        
    }
    
    
    
    func addChooseFromLibraryButton() {
        
        let button = UIButton()
        button.setTitle("Choose From Library", for: .normal)
        button.backgroundColor = Constants.deepOrange
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(self, action: #selector(chooseFromLibrary), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -220).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    @objc
    func chooseFromLibrary(sender : UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            //once complete
            print("\n=== User is choosing a profile picture ===")
        }
    }

}


extension EditProfileViewController: UIImagePickerControllerDelegate {
    
    //Once the user has chosen their image: check to see if able to use that image
    //!!!!!!!!!!!!!!!! NEED TO FIX PICTURE RATIOS WHEN CHOSEN !!!!!!!!!!!!!!!!!!!!!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //SET profile picture in the app
            userProfilePicture.image = image
            print("Step 1 of 2: Successfully set profile picture")
            
            //SEND the profile picture to the server
            //convert image into different type: UIImage -> Data -> String
            let imageData = image.jpegData(compressionQuality: 1)
            let imageStr = imageData!.base64EncodedString()
            
            //update the current user on the app
            let currentUser = UserDefaults.standard.getCurrentUser()
            currentUser.profilePicture = imageStr
            UserDefaults.standard.setCurrentUser(currentUser)
            
            //Create the request and encode the data
            let encoder = JSONEncoder()
            let jsonData = try! encoder.encode(currentUser)
            var urlRequest: URLRequest = URLRequest(url: updateProfilePictureURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsonData
            
            //send the request
            let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard let validData = data else {
                    print("invalid data")
                    return
                }
                //show response as string
                let newPath = try! JSONDecoder().decode(String.self, from: validData)
                print("Step 2 of 2: Successfully saved profile picture in server")
                currentUser.profilePicture = newPath
                UserDefaults.standard.setCurrentUser(currentUser)
            })
            dataTask.resume()
        } else {
            print("Error saving profile picture")
        }
        
        picker.dismiss(animated: false, completion: nil)
    }
    
    
}




extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        
        //Puts correct properties into the cell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
}



extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        print("Field updated to: \(updatedModel.inputValue ?? "nil")")
    }
    
    
}
