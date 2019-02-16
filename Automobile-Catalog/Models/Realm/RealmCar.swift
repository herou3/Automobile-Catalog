//
//  RealmCar.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmCar: Object, RealmEntity {

    // MARK: - Properties
    typealias TransientType = Car
    private static let taskPrimaryKey = "id"

    @objc dynamic var makeCompany: String?
    @objc dynamic var yearProduction: String?
    @objc dynamic var modelType: String?
    @objc dynamic var classType: String?
    @objc dynamic var subModelType: String?
    @objc dynamic var id: String?
    
    // MARK: - Methods
    override class func primaryKey() -> String? {
        return taskPrimaryKey
    }
    
    // MARK: - Realm transform
    static func from(transient: Car, in realm: Realm) -> RealmCar {
        
        let cached = realm.object(ofType: RealmCar.self, forPrimaryKey: transient.id)
        let realmCar: RealmCar
        
        if let cached = cached {
            realmCar = cached
        } else {
            realmCar = RealmCar()
            realmCar.id = transient.id ?? ""
        }
        
        realmCar.makeCompany = transient.makeCompany
        realmCar.yearProduction = String(transient.yearProduction ?? Constant.defaultYearProduction)
        realmCar.modelType = transient.modelType
        realmCar.classType = transient.classType
        realmCar.subModelType = transient.subModelType
        realmCar.id = transient.id
        
        return realmCar
    }
    
    func transient() -> Car {
        
        var transient = Car(makeCompany: "",
                            yearProduction: 0,
                            modelType: "",
                            classType: "",
                            subModelType: "",
                            id: UUID().uuidString)
        
        transient.makeCompany = makeCompany
        transient.yearProduction = Int(yearProduction ?? "\(Constant.defaultYearProduction)")
        transient.modelType = modelType
        transient.classType = classType
        transient.subModelType = subModelType
        transient.id = id
        
        return transient
    }
}
