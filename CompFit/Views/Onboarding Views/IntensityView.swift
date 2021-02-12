//
//  IntensityView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 1/30/21.
//

import UIKit

class IntensityView: UIView {
    
    var intensityStr: String = ""
    
    var intensityArray: [[String]] = [
        ["Low", "Low-intensity can also help you burn calories and drop pounds."],
        ["Medium", "A moderate level of activity noticeably increases your heart rate and breathing rate."],
        ["High", "One hundred percent effort through quick, intense bursts of exercise, followed by short, sometimes active, recovery periods."]
    ]
    
    
    var viewTitle: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "What is you experience working out?"
        textLabel.font = .boldSystemFont(ofSize: 27.0)
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
//        textLabel.lineBreakMode = .byWordWrapping
//        textLabel.lineBreakStrategy = .standard
//        textLabel.baselineAdjustment = .none
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true

        return textLabel
    }()
    
    
    var intensityView: UIView = {
        var view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    

    var views: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(viewTitle)
        
        
        for i in 0..<3 {
            let view = UIView()
            view.backgroundColor = .lightGray
            view.translatesAutoresizingMaskIntoConstraints = false

            views.append(view)
            addSubview(views[i])
        }


        backgroundColor = .white

        
    }

    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setFrame(view: CGRect) {
        self.frame = view
        
        setViewTitle()
        setIntensityViews()
    }
    
    
    func setIntensityViews() {
        
        let sizeOfView = 120.0
        
        for i in 0..<3 {
            //Constraints for the View
            views[i].topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: CGFloat(20.0 + (20.0 * Double(i)) + (sizeOfView * Double(i))) ).isActive = true
            views[i].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
            views[i].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17).isActive = true
            views[i].heightAnchor.constraint(equalToConstant: CGFloat(sizeOfView)).isActive = true
            views[i].layer.cornerRadius = 10
            
            //Create and constrain the label
            let label = UILabel()
            views[i].addSubview(label)
            label.text = intensityArray[i][0]
            label.font = .boldSystemFont(ofSize: 20.0)
//            label.backgroundColor = .systemPink
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: views[i].topAnchor, constant: 10).isActive = true
            label.leadingAnchor.constraint(equalTo: views[i].leadingAnchor, constant: 10).isActive = true
            label.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            //Create and constrain the description
            let desc = UILabel()
            views[i].addSubview(desc)
            desc.text = intensityArray[i][1]
            desc.font = .systemFont(ofSize: 18, weight: .light)
//            desc.backgroundColor = .systemRed
            desc.numberOfLines = 0
            
            desc.translatesAutoresizingMaskIntoConstraints = false
            desc.topAnchor.constraint(equalTo: views[i].topAnchor, constant: 50).isActive = true
            desc.leadingAnchor.constraint(equalTo: views[i].leadingAnchor, constant: 10).isActive = true
            desc.trailingAnchor.constraint(equalTo: views[i].trailingAnchor, constant: -10).isActive = true
            
            //Add function to detach taps on the View
            views[i].isUserInteractionEnabled = true
            let intensityTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(intensityTapped))
            views[i].addGestureRecognizer(intensityTapRecognizer)
            
        }
    }
    
    
    @objc
    func intensityTapped(recognizer: UITapGestureRecognizer) {
        let view = recognizer.view!
        
        let text = ((view.subviews[0] as? UILabel)?.text)!
//        print(text)
        intensityStr = text
        
        for i in 0..<views.count {
            let label = (views[i].subviews[0]) as? UILabel
            
            if label!.text == text {
                views[i].layer.masksToBounds = true
                views[i].layer.borderWidth = 5
                views[i].layer.borderColor = UIColor.orange.cgColor
            }
            else {
                views[i].layer.masksToBounds = false
                views[i].layer.borderWidth = 0
                views[i].layer.borderColor = UIColor.clear.cgColor
            }
        }
        

    }
    
    
    
    func setViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    
    
    
}
