//
//  CarDetailViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation

class CarDetailViewModel: CarDetailViewModelProtocol {
    
    // MARK: - Properties
    private var car: Car?
    
    var makeCompany: String?
    var yearProduction: String?
    var modelType: String?
    var classType: String?
    var subModelType: String?
    
    var numberOfRows: Int {
        return 0
    }
    
    // MARK: - init / deinit
    init(car: Car?) {
        self.car = car
        self.makeCompany = car?.makeCompany
        self.yearProduction = String(car?.yearProduction ?? Constant.defaultYearProduction)
        self.modelType = car?.modelType
        self.classType = car?.classType
        self.subModelType = car?.subModelType
    }
    
     // MARK: - Methods CarDetailViewModelProtocol
    func detailTableCellViewModel(forIndexPath indexPath: IndexPath) -> CarDetailTableCellViewModelProtocol? {
        return nil
    }
    
    func saveCar() {
        print("saveCar")
    }
    
    func modelCar() -> String {
        return "modelCar"
    }
}
