//
//  CarsListTableCellViewModelProtocol.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import UIKit

protocol CarsListTableCellViewModelProtocol: class {
    
    var makeCompany: String { get }
    var yearProduction: String { get }
    var modelType: String { get }
    var classType: String { get }
    var subModelType: String { get }
}
