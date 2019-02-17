//
//  CarDetailInfoCell.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

class CarDetailInfoCell: DefaultCell {
    
    // MARK: - Properties
    private var cellType: DefaultCellType?
    var changeTextBlock: ((_ text: String?) -> Void)?
    private var didTapReturnButtonBlock: (() -> Void)?

    // MARK: - Init table cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
    
    // MARK: - Create UIElements for cell
    private var typeInputLabel: UILabel = {
        let inputLabel = UILabel()
        inputLabel.textColor = .black
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.font = UIFont.systemFont(ofSize: 20)
        inputLabel.numberOfLines = 1
        return inputLabel
    }()
    
    var inputTextField: UITextField = {
        let inputTextField = UITextField()
        inputTextField.textColor = .slategray
        inputTextField.font = UIFont.systemFont(ofSize: 20)
        inputTextField.placeholder = "Enter text"
        inputTextField.tintColor = .black
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.autocapitalizationType = .words
        inputTextField.returnKeyType = .next
        inputTextField.clearButtonWithImage(UIImage(named: "clear-icon") ?? UIImage())
        return inputTextField
    }()
    
    lazy private var inputToolbar: UIToolbar = {
        
        var toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        var nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(tapNextButton(_:)))
        
        toolbar.setItems([fixedSpaceButton,
                          flexibleSpaceButton,
                          nextButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkslategray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var clearButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: - Configure car detail cell
    private func addTypeInputLabel() {
        addSubview(typeInputLabel)
        typeInputLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(Constant.marginLeftAndRightValue)
            make.bottom.equalTo(self).offset(-Constant.marginLeftAndRightValue)
            make.width.equalTo(140)
        }
    }
    
    private func addInputTextField() {
        addSubview(inputTextField)
        inputTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(Constant.marginLeftAndRightValue)
            make.left.equalTo(self.typeInputLabel.snp.right).offset(Constant.marginLeftAndRightValue)
            make.right.equalTo(self).offset(-Constant.marginLeftAndRightValue)
        }
        self.inputTextField.delegate = self
        self.inputTextField.addTarget(self, action: #selector(onDidUpdateText(_:)), for: .editingChanged)
    }
    
    private func addLineView() {
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(inputTextField.snp.bottom).offset(10)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(2)
            make.bottom.equalTo(self)
        }
    }
    
    private func setupClearButton() {
        for view in inputTextField.subviews {
            if let clearButton = view as? UIButton {
                clearButton.setImage(UIImage(named: "clear-icon") ?? UIImage(), for: .normal)
            }
        }
    }
    
    override func setupViews() {
        addTypeInputLabel()
        addInputTextField()
        addLineView()
        self.backgroundColor = .silver
    }
    
    func configure(with viewModel: CarDetailTableCellViewModelProtocol) {
        guard let carDetailInfoCellViewModel = viewModel as? CarDetailInfoCellViewModel else { return }
        self.cellType = carDetailInfoCellViewModel.cellType
        didTapReturnButtonBlock = { [weak carDetailInfoCellViewModel] in
            carDetailInfoCellViewModel?.requestSelectNextResponder()
        }
        typeInputLabel.text = cellType?.description
        if cellType == .yearProduction {
            inputTextField.keyboardType = .phonePad
        }
        inputTextField.text = viewModel.value
        inputTextField.placeholder = cellType?.description
    }
    
    // MARK: - Bind to viewModel
    @objc private func onDidUpdateText(_ textField: UITextField) {
        changeTextBlock?(textField.text)
    }
    
    // MARK: - Methods for toolBar
    @objc private func tapNextButton(_ sendor: UIBarButtonItem) {
        didTapReturnButtonBlock?()
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}

// MARK: - Extension textfield delegate
extension CarDetailInfoCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        didTapReturnButtonBlock?()
        
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if cellType == .yearProduction {
            guard var sanitizedText = textField.text else { return true }
            sanitizedText = sanitizedText.sanitizedYear()
            let newLenght = sanitizedText.count + string.count - range.length
            textField.text = sanitizedText
            
            return newLenght <= Constant.carPropertyCharactersCount
            
        } else {
            guard let sanitizedText = textField.text else { return true }
            let newLenght = sanitizedText.count + string.count - range.length
            
            return newLenght <= Constant.notePropertyCharcetersCount
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if cellType == .yearProduction {
            textField.inputAccessoryView = inputToolbar
        }
        
        return true
    }
}
