//
//  WorkoutTypeView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 1/31/21.
//


import UIKit


private var chosenWorkoutTypesSet: Set<String> = []

class WorkoutTypeView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var chosenWorkoutTypes: [String] = [String]()
    var workoutTypes: [String] = [String]()
    
    var viewTitle: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "What types of workouts do you enjoy?"
        textLabel.font = .boldSystemFont(ofSize: 27.0)
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true

        return textLabel
    }()
    
    


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(viewTitle)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    func setFrame(view: CGRect) {
        self.frame = view
        self.setViewTitle()

        // Gets the workout types from the database
        workoutTypes = RegisterNetworking.getWorkoutTypes()

        self.createTypeLabels()
    }
    
    
    func setViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
    var collectionView: UICollectionView?
    
    
    func createTypeLabels() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: 120, height: 45.0)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 7
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.backgroundColor = .clear
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -110).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17).isActive = true
    }
    
    func getChosenWorkoutTypes() -> [String]{
        chosenWorkoutTypes = Array(chosenWorkoutTypesSet)
        
        return chosenWorkoutTypes
    }
    
    
    //for data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutTypes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(label: workoutTypes[indexPath.row])
        return cell
    }
    


}



class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    var touchNumber = 0
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .systemGray
        self.contentView.layer.cornerRadius = 22

        contentView.addSubview(typeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        typeLabel.frame = CGRect(x: 0, y: contentView.frame.size.height-45, width: contentView.frame.size.width, height: 45)
    }
    
    
    public func configure(label: String) {
        typeLabel.text = label
        
        //Add function to detach taps on the View
        typeLabel.isUserInteractionEnabled = true
        let typeTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(typeTapped))
        typeLabel.addGestureRecognizer(typeTapRecognizer)

    }
    
    
    
    @objc
    func typeTapped(recognizer: UITapGestureRecognizer) {
        touchNumber += 1
        
        let tappedLabel = (recognizer.view as? UILabel)!
        let labelText = (tappedLabel.text)!
        
        if touchNumber % 2 != 0 {
            contentView.backgroundColor = Constants.Colors.brandBlue
            tappedLabel.textColor = .white
            chosenWorkoutTypesSet.insert(labelText)
        } else {
            contentView.backgroundColor = .systemGray
            tappedLabel.textColor = .black
            chosenWorkoutTypesSet.remove(labelText)
        }
    }
}
