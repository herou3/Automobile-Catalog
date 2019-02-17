//
//  CarDetailInfoCellViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

class CarDetailInfoCellViewModel: CarDetailTableCellViewModelProtocol {
    
    // MARK: - Properties
    var value: String?
    var cellType: DefaultCellType?
    var onDidTapReturnButton: (() -> Void)?
    
    // MARK: - init / deinit
    init(value: String?, cellType: DefaultCellType) {
        self.cellType = cellType
        self.configure(with: value)
    }
    
    // MARK: - Methods CarDetailTableCellViewModelProtocol
    func configure(with value: String?) {
        self.value = value
    }
    
    // MARK: - bind to Detail view model
    func requestSelectNextResponder() {
        onDidTapReturnButton?()
    }
}
