//
//  CarDetailDeleteCell.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

class CarDetailDeleteCell: DefaultCell {
    
    // MARK: - Properties
    var deleteRequestBlock: (() -> Void)?
    
    // MARK: - Init table cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
    
    // MARK: - Create UIElements for cell
    private var deleteButton: UIButton = {
        let subModelButton = UIButton()
        subModelButton.backgroundColor = .silver
        subModelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        subModelButton.tintColor = .black
        subModelButton.translatesAutoresizingMaskIntoConstraints = false
        subModelButton.contentHorizontalAlignment = .center
        subModelButton.setTitle("Delete Car", for: .normal)
        subModelButton.setTitleColor(.black, for: .normal)
        return subModelButton
    }()
    
    // MARK: - Configure delete cell
    private func addDeleteButton() {
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(Constant.marginLeftAndRightValue * 2)
            make.left.equalTo(self).offset(Constant.marginLeftAndRightValue * 4)
            make.right.equalTo(self).offset(-Constant.marginLeftAndRightValue * 4)
            make.bottom.equalTo(self).offset(-Constant.marginLeftAndRightValue * 2)
            make.height.equalTo(Constant.marginLeftAndRightValue * 4)
        }
        self.deleteButton.addTarget(self,
                                    action: #selector(onDidDeleteAction),
                                    for: .touchUpInside)
        self.backgroundColor = UIColor.lightslategray
    }
    
    override func setupViews() {
        addDeleteButton()
    }
    
    // MARK: - Bind to viewModel
    @objc private func onDidDeleteAction(_ sender: UIButton) {
        deleteRequestBlock?()
    }
}
