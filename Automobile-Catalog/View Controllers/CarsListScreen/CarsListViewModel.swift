//
//  CarsListViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation
import RealmSwift

class CarsListViewModel: CarsListViewModelProtocol {
    
    // MARK: - Properies
    private var cars: [Car] = []
    private var carExample: [Car]
    private var realm: Realm
    private var realmObjects: Results<RealmCar>!
    private var selectedIndexPath: IndexPath?
    private var realmWrapper = RealmWrapper()
    
    // MARK: - Init / deinit
    init() {
        realm = Realm.persistentStore()
        carExample = [Car(makeCompany: "Toyota",
                          yearProduction: 2016,
                          modelType: "Land cruiser 200",
                          classType: "Lux",
                          subModelType: "SUV",
                          id: UUID().uuidString),
                      Car(makeCompany: "BMW",
                          yearProduction: 2017,
                          modelType: "x6",
                          classType: "Lux",
                          subModelType: "Sedan",
                          id: UUID().uuidString),
                      Car(makeCompany: "LADA",
                          yearProduction: 2013,
                          modelType: "Granta",
                          classType: "Economic",
                          subModelType: "Sedan",
                          id: UUID().uuidString)]
        
        if realm.objects(RealmCar.self).isEmpty {
            for car in carExample {
                realmWrapper.saveObject(object: car)
            }
        }
        
        for obj in realm.objects(RealmCar.self) {
            let car = obj.transient()
            cars.append(car)
        }
    }
    
    // MARK: - Methods CarsListViewModelProtocol
    func numberOfRows(inSection section: Int) -> Int {
        return cars.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CarsListTableCellViewModelProtocol? {
        
        return CarTableCellViewModel(car: cars[indexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        
        print(cellViewModel(forIndexPath: indexPath)?.shortDevelopInfo ?? "XXX")
    }
    
    func showNewCarViewController() {
        print("Show")
    }
    
    // MARK: - Realm methods
    func updateCars(newCar: Car?) {
        guard let newCar = newCar else { return }
        if !(cars.map { $0.id }.contains(newCar.id)) {
            cars.append(newCar)
            realmWrapper.saveObject(object: newCar)
        } else {
            let index = cars.index(where: {$0.id == newCar.id })
            guard let curentIndex = index else { return }
            cars[curentIndex] = newCar
            for obj in realm.objects(RealmCar.self) where obj.id == cars[curentIndex].id {
                realmWrapper.saveObject(object: self.cars[curentIndex])
            }
        }
    }
    
    func deleteCars(car: Car?) {
        guard let car = car else { return }
        let index = cars.index(where: {$0.id == car.id })
        guard let curentIndex = index else { return }
        for obj in realm.objects(RealmCar.self) where obj.id == cars[curentIndex].id {
            realmWrapper.deleteObject(object: obj.transient())
        }
        cars.remove(at: curentIndex)
    }
}
