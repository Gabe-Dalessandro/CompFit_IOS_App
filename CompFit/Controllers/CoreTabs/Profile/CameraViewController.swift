//
//  CameraViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/16/21.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate {

    
    let userdata = Constants.currentUser
    let updateProfilePictureURL: URL = URL(string: HTTPRequests.update_profile_picture)!
    lazy var rightBarButton = UIBarButtonItem(title: "Back to Profile", style: .done, target: self, action: #selector(popToLeft))
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.hidesBackButton = true
    }
    
    
    override func viewDidLayoutSubviews() {
        addChooseFromLibraryButton()
        addUseCameraButton()
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
    
    
    @objc
    func chooseFromLibrary(sender : UIButton) {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        imageVC.sourceType = UIImagePickerController.SourceType.photoLibrary
        imageVC.allowsEditing = false
        
        
        self.present(imageVC, animated: true) {
            print("\n=== User is choosing a profile picture ===")
        }
    }
    
    
    @objc private func popToLeft() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window?.layer.add(transition, forKey: "from_right")
        
        self.navigationController?.popViewController(animated: false)
    }

}







extension CameraViewController: UIImagePickerControllerDelegate {
    
    //Once the user has chosen their image: check to see if able to use that image
    //!!!!!!!!!!!!!!!! NEED TO FIX PICTURE RATIOS WHEN CHOSEN !!!!!!!!!!!!!!!!!!!!!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let group = DispatchGroup()
        group.enter()
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //SET profile picture in the app
            print("Step 1 of 2: Successfully set profile picture")
            
            //SEND the profile picture to the server
            //convert image into different type: UIImage -> Data -> String
            let imageData = (image.jpegData(compressionQuality: 1))!
            let imageStr = imageData.base64EncodedString()
            
            //update the current user on the app
            let currentUser = UserDefaults.standard.getCurrentUser()
            currentUser.profilePictureData = imageStr
            
            //Encode the data
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try! encoder.encode(currentUser)
            
            // Create the request
            var urlRequest: URLRequest = URLRequest(url: updateProfilePictureURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsonData
            
            // Send the request
            let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard let validData = data else {
                    print("invalid data")
                    return
                }
                do {
                    //show response as string
                    let updatedUser = try JSONDecoder().decode(UserModel.self, from: validData)
                    print("Step 2 of 2: Successfully saved profile picture in AWS S3")
                    UserDefaults.standard.setCurrentUser(updatedUser, writeToUserDefaults: true)
                    group.leave()
                }
                catch {
                    print("error")
                }
            })
            dataTask.resume()
        } else {
            print("Error saving profile picture")
        }
        
        group.wait()
        
        picker.dismiss(animated: false, completion: nil)
        print("dismissing")
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window?.layer.add(transition, forKey: "from_right")
        self.navigationController?.popViewController(animated: false)
        
        print("showoing")
        let topVC = self.navigationController?.topViewController
//        topVC.didFinishEditing()
    }
    
    
}
