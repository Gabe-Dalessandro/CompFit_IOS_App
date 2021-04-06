//
//  CameraViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/16/21.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate {

    let userdata = Constants.currentUser
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
        button.backgroundColor = Constants.Colors.brandDarkGrey
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.titleLabel?.textAlignment = .center
        button.tintColor = .white
        
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
        button.backgroundColor = Constants.Colors.brandDarkGrey
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.titleLabel?.textAlignment = .center
        button.tintColor = .white
        
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
        // If the picture chosen is acceptable
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("Step 1 of 2: Successfully set profile picture")
            
            //SEND the profile picture to the server
            //convert image into different type: UIImage -> Data -> String
            let imageData = (image.jpegData(compressionQuality: 1))!
            let imageStr = imageData.base64EncodedString()
            
            ProfileNetworking.changeProfilePicture(imageStr: imageStr)
        } else {
            print("Error saving profile picture")
        }
        
        // Transition back to profile
        // Get the navigation controller that the camera view is a part of
        let profileNav = self.navigationController
        picker.dismiss(animated: false, completion: nil)

        // Do a leftward transition
        self.popToLeft()
        
        // Update the profileVC to show the new picture
        let topVC = profileNav?.topViewController as! ProfileViewController
        topVC.didFinishEditing()
    }
}
