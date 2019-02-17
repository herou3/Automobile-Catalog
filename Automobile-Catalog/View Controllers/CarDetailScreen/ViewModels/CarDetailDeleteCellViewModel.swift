//
//  CarDetailDeleteCellViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

class CarDetailDeleteCellViewModel: CarDetailTableCellViewModelProtocol {
    
    // MARK: - Properties
    var value: String?
    var deleteRequestBlock: (() -> Void)?
    
    // MARK: - Init / deinit
    init(value: String?) {
        self.deleteRequestBlock = deleteAction
    }
    
    // MARK: - Methods CarDetailTableCellViewModelProtocol
    func configure(with value: String?) {
        self.value = value
    }
    
    // MARK: - Internal Methods
    func deleteAction() {
        self.deleteRequestBlock?()
    }
}
