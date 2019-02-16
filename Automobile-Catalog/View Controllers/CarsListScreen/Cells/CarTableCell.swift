//
//  CarTableCell.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

class CarTableCell: DefaultCell {
    
    // MARK: - Init table cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
    
    // MARK: - Create UIElements for cell
    private var carShortDevelopInfoLabel: UILabel = {
        let carShortDevelopInfoLabel = UILabel()
        carShortDevelopInfoLabel.text = "default string"
        carShortDevelopInfoLabel.textColor = .black
        carShortDevelopInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        carShortDevelopInfoLabel.font = UIFont.systemFont(ofSize: 18)
        carShortDevelopInfoLabel.numberOfLines = 2
        return carShortDevelopInfoLabel
    }()
    
    private var carSubModelTypeImageView: UIImageView = {
        let subModelTypeImageView = UIImageView()
        subModelTypeImageView.image = UIImage()
        subModelTypeImageView.translatesAutoresizingMaskIntoConstraints = false
        subModelTypeImageView.contentMode = .scaleAspectFill
        subModelTypeImageView.clipsToBounds = true
        return subModelTypeImageView
    }()
    
    private var carClassTypeLabel: UILabel = {
        let classTypeLabel = UILabel()
        classTypeLabel.text = "None"
        classTypeLabel.textColor = .gray
        classTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        classTypeLabel.font = UIFont.systemFont(ofSize: 18)
        classTypeLabel.numberOfLines = 1
        return classTypeLabel
    }()
    
    // MARK: - Configure CarCell
    private func addCarShortDevelopInfoLabel() {
        addSubview(carShortDevelopInfoLabel)
        carShortDevelopInfoLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(Constant.marginLeftAndRightValue)
            make.right.equalTo(self.snp.right).offset(-Constant.marginLeftAndRightValue)
            make.height.equalTo(Constant.heightInfoLabel)
        }
    }
    
    private func addSubModelTypeImageView() {
        addSubview(carSubModelTypeImageView)
        carSubModelTypeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.carShortDevelopInfoLabel.snp.bottom).offset(Constant.marginLeftAndRightValue)
            make.width.equalTo(Constant.heightInfoLabel)
            make.bottom.equalTo(self).offset(-Constant.marginLeftAndRightValue)
            make.right.equalTo(self.snp.right).offset(-Constant.marginLeftAndRightValue)
        }
    }
    
    private func addClassTypeLabel() {
        addSubview(carClassTypeLabel)
        carClassTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carSubModelTypeImageView.snp.top)
            make.left.equalTo(self.bounds.width / 2).offset(Constant.marginLeftAndRightValue)
        }
    }
    
    override func setupViews() {
        addCarShortDevelopInfoLabel()
        addSubModelTypeImageView()
        addClassTypeLabel()
    }
    
    func updateDataForCell(with viewModel: CarsListTableCellViewModelProtocol) {
        carShortDevelopInfoLabel.text = viewModel.shortDevelopInfo
        carClassTypeLabel.text = viewModel.classType
        if viewModel.subModelType.elementsEqual(SubMoodelType.sedan.description) {
            carSubModelTypeImageView.image = UIImage(named: "sedan-icon")
        } else if viewModel.subModelType.elementsEqual(SubMoodelType.pickup.description) {
            carSubModelTypeImageView.image = UIImage(named: "pickup-icon")
        } else if viewModel.subModelType.elementsEqual(SubMoodelType.estate.description) {
            carSubModelTypeImageView.image = UIImage(named: "estate-icon")
        } else if viewModel.subModelType.elementsEqual(SubMoodelType.hatchback.description) {
            carSubModelTypeImageView.image = UIImage(named: "hatchback-icon")
        } else if viewModel.subModelType.elementsEqual(SubMoodelType.minivan.description) {
            carSubModelTypeImageView.image = UIImage(named: "minivan-icon")
        } else if viewModel.subModelType.elementsEqual(SubMoodelType.suv.description) {
            carSubModelTypeImageView.image = UIImage(named: "suv-icon")
        }
    }
}
