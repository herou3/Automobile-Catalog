//
//  Car.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation

struct Car: TransientEntity {
    
    // MARK: - Properties
    typealias RealmType = RealmCar
    
    var makeCompany: String?
    var yearProduction: Int?
    var modelType: String?
    var classType: String?
    var subModelType: String?
    var id: String?
}
