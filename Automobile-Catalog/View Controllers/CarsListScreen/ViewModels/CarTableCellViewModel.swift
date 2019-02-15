//
//  CarTableCellViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import UIKit
import SnapKit

class ContactTableCell: CarsListTableCellViewModelProtocol {
    
    // MARK: - Properies
    private var car: Car
    
    var makeCompany: String {
        let makeCompany = car.makeCompany ?? ""
        return makeCompany
    }
    
    var yearProduction: String {
        let yearProduction = car.yearProduction ?? Constant.defaultYearProduction
        return String(yearProduction)
    }
    
    var modelType: String {
        let modelType = car.modelType ?? ""
        return modelType
    }
    
    var classType: String {
        let classType = car.classType ?? ""
        return classType
    }
    
    var subModelType: String {
        let subModelType = car.subModelType ?? ""
        return subModelType
    }
    
    // MARK: - Init / deinit
    init(car: Car) {
        self.car = car
    }
}
