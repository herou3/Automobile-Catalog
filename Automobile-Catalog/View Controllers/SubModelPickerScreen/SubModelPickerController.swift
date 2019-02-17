//
//  SubModelPickerController.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 17.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import UIKit

class SubModelPickerController: UIViewController {
    
    // MARK: - Properties
    private let subModelPickerViewModel: SubModelPickerViewModel?
    private let subModelPickerView = UIPickerView()
    private var subModel: String?
    
    // MARK: - Init / deinit
    init(viewModel: SubModelPickerViewModel) {
        self.subModelPickerViewModel = viewModel
        subModel = self.subModelPickerViewModel?.subModelValue(forRow: 0)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubModelPickerController()
    }
    
    // MARK: - Configure sound picker controller
    private func addSubModelPickerView() {
        self.view.addSubview(subModelPickerView)
        subModelPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        self.subModelPickerView.delegate = self
        self.subModelPickerView.dataSource = self
        self.subModelPickerView.backgroundColor = .silver
        self.subModelPickerView.tintColor = UIColor.appPrimary
    }
    
    private func configureSubModelPickerController() {
        addSubModelPickerView()
    }
    
    // MARK: - Internal methods
    @objc private func saveSubModelValue() {
        guard let chosenSubModel = self.subModel else {
            return
        }
        subModelPickerViewModel?.saveSubModelValue(chosenSubModel)
    }
    
    @objc private func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Return navigationItems
    func barButtonItem(type: ItemButtonType) -> UIBarButtonItem {
        switch type {
        case .done:
            return UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self,
                                   action: #selector(saveSubModelValue))
        default:
            return UIBarButtonItem(title: "Close",
                                   style: .done,
                                   target: self,
                                   action: #selector(closeViewController))
        }
    }
}

// MARK: - Extension UIPickerViewDelegate and UIPickerViewDataSource
extension SubModelPickerController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.subModelPickerViewModel?.numberOfRows ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.subModel = self.subModelPickerViewModel?.subModelValue(forRow: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.subModelPickerViewModel?.subModelValue(forRow: row)
    }
}
