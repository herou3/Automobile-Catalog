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
    
    // MARK: - Methods CarDetailTableCellViewModelProtocol
    func configure(with value: String?) {
        self.value = value
    }
}
