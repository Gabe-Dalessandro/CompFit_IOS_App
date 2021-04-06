//
//  ExploreViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/9/21.
//

import UIKit


//A user will be able to discover new content from users they follow, or from a TikTok type feature, or from a tab that serves content that is similar to their interests/history
import UIKit

class DiscoverViewController: UIViewController {

    let searchVC: UISearchController = {
        let searchVC = UISearchController(searchResultsController: SearchResultsViewController())
        searchVC.searchBar.placeholder = "Search..."
        return searchVC
    }()
    
    var collectionView: UICollectionView!
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            
            if sectionIndex == 0 {
                return self.createWorkoutTypeSection()
            }
            else {
                return self.createFeaturedTrainersSection()
            }
            
        }
        
        //Configure the layout with proper spacing between things
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Setup for Navigation Bar and SearchBar
        setNavigation()
        (searchVC.searchResultsController as? SearchResultsViewController)?.delegate = self
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.delegate = self
        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        
        
        // Register the Cells and Headers
        // Workout Types Cells
        collectionView.register(DiscoverWorkoutTypesCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverWorkoutTypesCollectionViewCell.identifier)
        // Featured Trainers
        collectionView.register(DiscoverFeaturedTrainersCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverFeaturedTrainersCollectionViewCell.identifier)
        // Featured Trainer Header
        collectionView.register(DiscoverFeaturedTrainersSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DiscoverFeaturedTrainersSectionHeader.identifier)
        
        
        // Add to view and set delegates
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    
    // Styles the navigation bar: to have the title on the left, the search bar in the navbar, and to have a larger navbar area
    private func setNavigation() {
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.poppinsBold(size: 34)
        ]
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = attrs as [NSAttributedString.Key : Any]
        
        navigationItem.searchController = searchVC
    }
    
    
    // Section 0: Workout Types
    func createWorkoutTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let workoutTypeItem = NSCollectionLayoutItem(layoutSize: itemSize)
        workoutTypeItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(3/4), heightDimension: .fractionalWidth(2/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [workoutTypeItem])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    
    // Section 1: Featured Trainers
    func createFeaturedTrainersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(3/5), heightDimension: .fractionalHeight(1/7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // Add the Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
}












/* Collection View
    Handles displaying rows and sections within the collection view
 */
extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Headers:
        // displays the correct header for each section
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (indexPath.section == 1) {
            let featuredTrainersHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DiscoverFeaturedTrainersSectionHeader.identifier, for: indexPath) as! DiscoverFeaturedTrainersSectionHeader

            featuredTrainersHeader.delegate = self
            return featuredTrainersHeader
        }
        
        return UICollectionReusableView()
    }
    
    
    // Sections:
        // Returns how many sections you want in the collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    // Items:
        // Returns the number of items you want in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    // Displays Items:
        // Uses the item you specify depending on the section we are in or item number we are on
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let images = ["test-workout-type1", "test-workout-type2", "test-workout-type3"]
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverWorkoutTypesCollectionViewCell.identifier, for: indexPath) as! DiscoverWorkoutTypesCollectionViewCell
            cell.setImageViewImage(imageName: images[indexPath.row % 3])
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverFeaturedTrainersCollectionViewCell.identifier, for: indexPath) as! DiscoverFeaturedTrainersCollectionViewCell
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}



/* For "View All" taps
    Displays the next view controller when tapping view all
 */
extension DiscoverViewController: DiscoverFeaturedTrainersSectionHeaderDelegate {
    func didTapViewAll() {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        vc.title = "Featured Trainers"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}






/* For Search Bar Controller
    Sends the search term within the search bar to the Networking class
 */
extension DiscoverViewController: UISearchResultsUpdating {
    
    // Gets the search term and modifies it before querying database
    func updateSearchResults(for searchController: UISearchController) {
        // Make sure we get rid of whitespace on the search term
        guard let resultsVC = searchController.searchResultsController as? SearchResultsViewController,
              let searchTerm = searchController.searchBar.text,
              !searchTerm.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            return
        }
        
        let queryResults = DiscoverNetworking.searchUsers(searchParameter: searchTerm)
        resultsVC.update(with: queryResults)
    }
    
}




/* For Search Bar Controller
 Used when tapping on a earch result within the Search Results VC Table view
 */
extension DiscoverViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewController(vc: SearchResultsViewController, didSelectResultsWith user: UserModel) {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        vc.title = user.email
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension DiscoverViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }
}




