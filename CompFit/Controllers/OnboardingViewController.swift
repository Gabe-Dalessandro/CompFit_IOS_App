//
//  ViewController.swift
//  PageVCTutorial
//
//  Created by Gabriel Dalessandro on 1/30/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //api call to register a new user
    let registerUrlStr = "http://127.0.0.1:8000/api/user/register/"
    
    //data from register view controller
    var emailStr = ""
    var passwordStr = ""
    var phoneNumberStr = ""
    
    
    var view0 = BirthdateView()
    var view1 = GenderView()
    var view2 = WorkoutExperienceView()
    var view3 = WorkoutTypeView()
    var view4 = IntensityView()
    var view5 = AppleHealthView()
    
    
    lazy var onboardingViews = [view0,
                      view1,
                      view2,
                      view3,
                      view4,
                      view5,]
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        
        //sets the entire size of the scroll view: the size might span multiple pages
        //(ie if there is 4 pages of scrolling, this will = page size * 4)
        scrollView.contentSize = CGSize(width: (view.frame.width * CGFloat(onboardingViews.count)), height: view.frame.height - 170)
        
        //add our custom views to the scroll view including where each view begins in the entire width and height of the scroll view
        var newView = (onboardingViews[0] as? BirthdateView)!
        newView.setFrame(view: CGRect(x: (view.frame.width * CGFloat(0)), y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.addSubview(onboardingViews[0])
        
        var newView1 = (onboardingViews[1] as? GenderView)!
        newView1.setFrame(view: CGRect(x: (view.frame.width * CGFloat(1)), y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.addSubview(onboardingViews[1])
        
        var newView2 = (onboardingViews[2] as? WorkoutExperienceView)!
        newView2.setFrame(view: CGRect(x: (view.frame.width * CGFloat(2)), y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.addSubview(onboardingViews[2])
        
        var newView3 = (onboardingViews[3] as? WorkoutTypeView)!
        newView3.setFrame(view: CGRect(x: (view.frame.width * CGFloat(3)), y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.addSubview(onboardingViews[3])
        
        var newView4 = (onboardingViews[4] as? IntensityView)!
        newView4.setFrame(view: CGRect(x: (view.frame.width * CGFloat(4)), y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.addSubview(onboardingViews[4])
        
        var newView5 = (onboardingViews[5] as? AppleHealthView)!
        newView5.setFrame(view: CGRect(x: (view.frame.width * CGFloat(5)), y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.addSubview(onboardingViews[5])
        
        
//        for i in 5..<onboardingViews.count {
//            scrollView.addSubview(onboardingViews[i])
//
//            print("In the loop")
//            print(view.frame.width * CGFloat(i))
//
//            onboardingViews[i].frame = CGRect(x: (view.frame.width * CGFloat(i)), y: 0, width: view.frame.width, height: view.frame.height)
//        }
        
        //Remember to add the delegate: self in this case is the actual UIViewController class
        scrollView.delegate = self
        
        return scrollView
    }()
    
    
    

    var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        
        return button
    }()
    
    
    let myGroup = DispatchGroup()
    @objc func submitPressed(sender : UIButton) {
//        var birthdate = view0.birthdateStr
//        var gender = view1.chosenGenderStr
//        var experience = view2.experienceStr
//        var workoutTypes = view3.getChosenWorkoutTypes()
//        var intensity = view4.intensityStr
//        var appleHealth = view5.appleHealthStr
        
        let email = emailStr
        let password = passwordStr
        let phoneNumber = phoneNumberStr
        let birthday = "2001-05-21"
        let totalPoints = 0
        let gender = "Male"
        let experience = "Beginner"
        let workoutTypes = ["HIIT", "Yoga", "Plyometrics"]
        let intensity = "High"
//        let appleHealth = "TBD"
        
        let newUser = UserModel(email: email, password: password,
                           phoneNumber: phoneNumber, birthday: birthday,
                           totalPoints: totalPoints, gender: gender,
                           fitnessExp: experience, workoutIntensity: intensity,
                           workoutTypes: workoutTypes)
        
//        print("\n\nNewUser: \(newUser)")
        
        if ( (email != "") && (password != "") && (phoneNumber != "") && (birthday != "") && (gender != "") && (experience != "") && (intensity != "") ) {
            registerNewUser(userData: newUser)
        }
        
        myGroup.notify(queue: .main) {
            self.transitionToMainApp()
        }
    }
    
    
    func registerNewUser(userData newUser: UserModel) {
        // Json Encoder
        myGroup.enter()
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(newUser)
        
        // Construct the request using the url
        guard let url = URL(string: registerUrlStr) else {fatalError()}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        // Create a task to do using a session
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if (error != nil) {
                print("\n=== Error in POST request 'user/post' ===")
                print(error ?? "error")
            } else {
                //ensure the response status is 200 OK and that there is data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let validData = data else {
//                            completion(.failure(.responseProblem))
                    return
                }
                
                // runs if we get the data from the response
                do {
                    let newUserData = try JSONDecoder().decode(UserModel.self, from: validData)
                    print("\n\n=== Registration Successful! ===")
                    print("New Registered User: \t\(newUserData)")
                    
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setCurrentUser(newUserData, writeToUserDefaults: true)
                    self.myGroup.leave()
                } catch {
                    print("error from response in 'user/post'")
                    self.myGroup.leave()
                }
            } //else
        } //let dataTask
        
        dataTask.resume()
    }
    
    
    
    func transitionToMainApp() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.viewControllers = []
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.isModalInPresentation = false
        
        present(mainTabBarController, animated: true, completion: nil)
    }
    
    
    
    //Submit button that will register the user into the database
    func setSubmitButton() {
        view.addSubview(submitButton)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -110).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        submitButton.isHidden = true
    }
    
    
    //Sets the constraints of the scroll view that was created for this view controller
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScrollView()
        
        setSubmitButton()
        
        setupBottomControls()
    }
    
 
    
        
    
    // ==== Page Control ===
        //used to click through a set number of pages on the screen
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingViews.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .systemOrange
        pageControl.pageIndicatorTintColor = .systemGray
        //pageControl.preferredIndicatorImage = UIImage() //use this to have a custom image for the dot
                
        return pageControl
    }()
    
    //PREV Button and its function
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        return button
    }()
    
    @objc private func handlePrev(){
        let prevIndex = max(pageControl.currentPage - 1, 0)
        pageControl.currentPage = prevIndex
        scrollView.scrollTo(horizontalPage: pageControl.currentPage, animated: true)
        
        if pageControl.currentPage == 5 {
            submitButton.isHidden = false
        } else {
            submitButton.isHidden = true
        }
    }
    
    
    //NEXT Button and its function
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        return button
    }()
    
    @objc private func handleNext(){
        let nextIndex = min(pageControl.currentPage + 1, onboardingViews.count - 1)
        pageControl.currentPage = nextIndex
        scrollView.scrollTo(horizontalPage: pageControl.currentPage, animated: true)
        
        if pageControl.currentPage == 5 {
            submitButton.isHidden = false
        } else {
            submitButton.isHidden = true
        }
    }
    
    
    
    //Puts the onboarding buttons and page view controller into a stack view at the bottom of the screen
    fileprivate func setupBottomControls() {
        // Create a stack view to help arrange items within this area of the screen
        let bottomControlsStackView = UIStackView(arrangedSubviews: [
            previousButton,
            pageControl,
            nextButton
        ])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillProportionally

        view.addSubview(bottomControlsStackView)

        //Placing the stackview on the bottom of the screen with constraints
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}








//Extensions for a ScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //get the page index when we are scrolling on the scroll view
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension UIScrollView {
    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }
}
