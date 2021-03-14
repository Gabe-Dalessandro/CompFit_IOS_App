//
//  SettingViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/8/21.
//

import UIKit


struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}


/// View Controller to show user Settings
final class SettingsViewController: UIViewController {
    
    private var settingsData = [[SettingCellModel]]() //2D in order to have multiple sections
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Settings"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemRed
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //Called before the view's bounds change, but BEFORE it lays out its subviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

    //Called when the view's bounds change, but AFTER it lays out its subviews
    //Useful to start animations on the screen
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    //Add sections to the table view, as well as the items within that sections
    func configureModels() {
        //General section
        settingsData.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapInviteFriends()
            },
            
            SettingCellModel(title: "Save Original Posts") { [weak self] in
                
            }
        ])
        
        //Terms and Help section
        settingsData.append([
            SettingCellModel(title: "Terms of Service") { [weak self] in
                self?.openURL(type: .terms)
            },
            
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        //Log Out section
        settingsData.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogout()
            }
        ])
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        
        switch type {
        case .terms: urlString = ""
        case .help: urlString = ""
        case .privacy: urlString = ""
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        
    }
    
    private func didTapLogout(){
        let logoutActionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        logoutActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        logoutActionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            print("User log out")
            UserDefaults.standard.setIsLoggedIn(value: false)
            self.perform(#selector(self.showWelcomeViewController), with: nil, afterDelay: 0.01)
        }))
        
        //Used for Ipad
        logoutActionSheet.popoverPresentationController?.sourceView = tableView
        logoutActionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(logoutActionSheet, animated: true, completion: nil)
    }
    
    @objc
    private func showWelcomeViewController() {
        let mainNavigationController = MainNavigationController()
        let welcomeViewController = WelcomeViewController()
        mainNavigationController.modalPresentationStyle = .fullScreen
        mainNavigationController.viewControllers = [welcomeViewController]
                
        present(mainNavigationController, animated: true, completion: nil)
    }
    

    
    private func didTapEditProfile(){
        let editVC = EditProfileViewController()
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    
    private func didTapInviteFriends(){
        // Show a share sheet to invite friends
        
    }
    
}





///Tableview Delegate Functions
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = settingsData[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = settingsData[indexPath.section][indexPath.row]
        cellModel.handler()
    }
    
    
}
