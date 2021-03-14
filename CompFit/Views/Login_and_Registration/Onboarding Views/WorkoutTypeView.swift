//
//  WorkoutTypeView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 1/31/21.
//


import UIKit


private var chosenWorkoutTypesSet: Set<String> = []

class WorkoutTypeView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var chosenWorkoutTypes: [String] = []
    var workoutTypes: [String] = []
    
    public var urlStr = HTTPRequests.get_workout_types
    
    
    
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
    
    
    public func getWorkoutTypes() {
        myGroup.enter()
        let url = URL(string: urlStr)!
        
//        var session = URLSession(configuration: .default)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error within: \(self.urlStr)")
                print(error!)
            }

            if let safeData = data {
//                print("Printing the safeData:")
//                print(safeData)

                do {
                    let result = try JSONDecoder().decode([String].self, from: safeData)
//                    print("\nPrinting out data from server:")
//                    print(result)
                    self.workoutTypes = result
                    self.myGroup.leave()
                } catch {
                    print("failed to convert \(error.localizedDescription)")
                }

            } else {
                print("Error within: \(self.urlStr)")
                print("\terror when grabbing data")
                return
            }
        }
        task.resume()
    }

    
    //Used to retrieve data from the api: multithreading to allow us to get data first before displaying it
        //populated the workoutTypes array within the class so we can make them into labels and display them
    let myGroup = DispatchGroup()
    
    func setFrame(view: CGRect) {
        self.frame = view
        
        getWorkoutTypes()

        myGroup.notify(queue: .main) {
//            print("\nFinished the request")
            self.setViewTitle()
            self.createTypeLabels()
        }
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
        
//        let height = self.frame.size.height
//        let width = self.frame.width
//        print("height: \(height)")
//        print("width: \(width)\n")

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
        
//        var height = typeLabel.frame.height
//        var width = typeLabel.frame.width
//
//        print("height: \(height)")
//        print("width: \(width)\n")
    }
    
    
    
    @objc
    func typeTapped(recognizer: UITapGestureRecognizer) {
        touchNumber += 1
        
        let tappedLabel = (recognizer.view as? UILabel)!
        let labelText = (tappedLabel.text)!
        
        if touchNumber % 2 != 0 {
//            contentView.layer.borderWidth = 4
//            contentView.layer.borderColor = CGColor(red: 255.0/255.0, green: 140.0/255.0, blue: 0, alpha: 1)
            contentView.backgroundColor = .systemOrange
            tappedLabel.textColor = .white
            chosenWorkoutTypesSet.insert(labelText)
        } else {
//            contentView.layer.borderWidth = 0
            contentView.backgroundColor = .systemGray
            tappedLabel.textColor = .black
            chosenWorkoutTypesSet.remove(labelText)
        }
    }
}
