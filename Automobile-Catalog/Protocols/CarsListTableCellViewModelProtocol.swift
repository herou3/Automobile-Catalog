//
//  CarsListTableCellViewModelProtocol.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import UIKit

protocol CarsListTableCellViewModelProtocol: class {
    
    var shortDevelopInfo: String { get }
    var classType: String { get }
    var subModelType: String { get }
}
