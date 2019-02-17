//
//  CarDetailSubModelCellViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

class CarDetailSubModelCellViewModel: CarDetailTableCellViewModelProtocol {
    
    // MARK: - Properties
    var value: String?
    var onDidChangedSubModelState: (() -> Void)?
    
    // MARK: - init / deinit
    init(value: String?) {
        self.configure(with: value)
    }
    
    // MARK: - Methods CarDetailTableCellViewModelProtocol
    func configure(with value: String?) {
        guard let value = value  else { return }
        self.value = value
    }
    
    // MARK: - Change data use text
    func requestShowSubModel() {
        self.onDidChangedSubModelState?()
    }
}
