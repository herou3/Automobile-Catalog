//
//  CarDetailViewModelProtocol.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import UIKit

protocol CarDetailViewModelProtocol {
    
    var makeCompany: String? { get set }
    var yearProduction: String? { get set }
    var modelType: String? { get set }
    var classType: String? { get set }
    var subModelType: String? { get set }
    
    var numberOfRows: Int { get }
    
    func detailTableCellViewModel(forIndexPath indexPath: IndexPath) -> CarDetailTableCellViewModelProtocol?
    func saveCar()
    func modelCar() -> String
}
