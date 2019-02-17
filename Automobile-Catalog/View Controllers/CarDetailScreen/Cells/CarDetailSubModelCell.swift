//
//  CarDetailSubModelCell.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

class CarDetailSubModelCell: DefaultCell {
    
    // MARK: - Properties
    var changeSubModelBlock: (() -> Void)?
    
    // MARK: - Init table cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
    
    // MARK: - Create UIElements for cell
    private var chooseSubModelButton: UIButton = {
        let subModelButton = UIButton()
        subModelButton.backgroundColor = .silver
        subModelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        subModelButton.tintColor = .black
        subModelButton.translatesAutoresizingMaskIntoConstraints = false
        subModelButton.contentHorizontalAlignment = .left
        return subModelButton
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkslategray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Configure subModel cell
    private func addChooseSubModelButton() {
        addSubview(chooseSubModelButton)
        chooseSubModelButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(Constant.marginLeftAndRightValue / 2)
            make.left.equalTo(self).offset(Constant.marginLeftAndRightValue)
            make.right.equalTo(self).offset(-Constant.marginLeftAndRightValue)
            make.bottom.equalTo(self).offset(-Constant.marginLeftAndRightValue / 2)
        }
        self.chooseSubModelButton.addTarget(self,
                                         action: #selector(onDidChangeSubModel),
                                         for: .touchUpInside)
    }
    
    private func addLineView() {
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).offset(-2)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(2)
            make.bottom.equalTo(self)
        }
    }
    
    override func setupViews() {
        addChooseSubModelButton()
        addLineView()
        self.backgroundColor = .silver
    }
    
    func configure(with viewModel: CarDetailTableCellViewModelProtocol) {
        
        guard viewModel is CarDetailSubModelCellViewModel else { return }
        if viewModel.value != nil {
            chooseSubModelButton.setTitle(viewModel.value, for: .normal)
        } else {
            chooseSubModelButton.setTitle("Choice subModel", for: .normal)
        }
        chooseSubModelButton.setTitleColor(.slategray, for: .normal)
    }
    
    // MARK: - Bind to viewModel
    @objc private func onDidChangeSubModel(_ sender: UIButton) {
        changeSubModelBlock?()
    }
}
