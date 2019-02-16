//
//  CarTableCellViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

enum SubMoodelType {
    case sedan, suv, hatchback, estate, minivan, pickup
    
    var description: String {
        switch self {
        case .sedan:
            return "Sedan"
        case .suv:
            return "SUV"
        case .hatchback:
            return "Hatchback"
        case .estate:
            return "Estate"
        case .minivan:
            return "Minivan"
        case .pickup:
            return "Pickup"
        }
    }
}

class CarTableCellViewModel: CarsListTableCellViewModelProtocol {
    
    // MARK: - Properies
    private var car: Car
    
    var shortDevelopInfo: String {
        let shortDevelopInfo =
            String("\(car.makeCompany ?? "") \(car.modelType ?? ""), \(String(car.yearProduction ?? Constant.defaultYearProduction))")
        return shortDevelopInfo
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
