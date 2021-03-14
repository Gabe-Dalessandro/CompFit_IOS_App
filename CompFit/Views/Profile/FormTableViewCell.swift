//
//  FormTableViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/8/21.
//

import UIKit

//Used to return the value to the View Controller
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}


class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FormTableViewCell"
    public weak var delegate: FormTableViewCellDelegate?
    private var model: EditProfileFormModel?
    
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let formTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(formTextField)
        self.selectionStyle = .none
        
        //Have to get the value out of the field and into the controller
        formTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Called when a table view cell is created and ready to layout the subviews within itself
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Assign the frames
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.width/3, height: contentView.frame.height)
        formTextField.frame = CGRect(x: formLabel.frame.maxX + 5, y: 0, width: contentView.frame.width - 10 - formLabel.frame.width, height: contentView.frame.height)
    }
    
    //Everytime the cell is reused, we want to add our custom functionality
    //Resets all of the assignments
    //Ensures that the prior cells vlue is never used to create the next cell
    override func prepareForReuse() {
        super.prepareForReuse()
        self.formLabel.text = nil
        self.formTextField.placeholder = nil
        self.formTextField.text = nil
    }
    
    
    
    //Used to configure the cell using the model it is given
    public func configure(with model: EditProfileFormModel){
        self.model = model
        self.formLabel.text = model.formFieldLabel
        self.formTextField.placeholder = model.placeholder
        self.formTextField.text = model.inputValue
    }
    
    
    
    
    
    //Gets rid of the keyboard when the user hits "return" on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.inputValue = textField.text
        guard let model = self.model else{
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }

    
}
