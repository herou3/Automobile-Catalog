//
//  CarDetailViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation

enum DefaultCellType {
    case makeCompany, yearProduction, modelType, classType
    
    var description: String {
        switch self {
        case .makeCompany:
            return "Devoloper"
        case .yearProduction:
            return "Year"
        case .modelType:
            return "Model"
        case .classType:
            return "Class"
        }
    }
}

enum CellType: Int {
    case makeCompanyCell, yearProductionCell, modelTypeCell, classTypeCell, subModelCell, deleteCell
}

protocol CarDetailViewModelDelegate: class {
    
    func carDetailViewModelDidReqestShowSubModelPicker(_ viewMidel: CarDetailViewModel)
    func carDetailViewModel(_ viewModel: CarDetailViewModel, didSaveCar car: Car?)
    func carDetailViewModel(_ viewModel: CarDetailViewModel, didDeleteCar car: Car?)
}

class CarDetailViewModel: CarDetailViewModelProtocol {
    
    // MARK: - Properties
    private var car: Car?
    private var carsCellsViewModels: [CarDetailTableCellViewModelProtocol] = []
    weak var delegate: CarDetailViewModelDelegate?
    
    private var onDidUpdateDataSourceBlock: (() -> Void)?
    private var onDidUpdateSubModelBlock: ((_ value: String?) -> Void)?
    
    var onDidChangeSubModelBlock: (() -> Void)?
    var onDidRequestOfDeleteBlock: (() -> Void)?
    var onDidRequestTapBlock: ((_ nextNumberCell: Int) -> Void)?
    
    var makeCompany: String?
    var yearProduction: String?
    var modelType: String?
    var classType: String?
    var subModelType: String?
    
    var numberOfRows: Int {
        return carsCellsViewModels.count
    }
    
    // MARK: - init / deinit
    init(car: Car?) {
        self.car = car
        self.makeCompany = car?.makeCompany
        self.yearProduction = String(car?.yearProduction ?? 0)
        self.modelType = car?.modelType
        self.classType = car?.classType
        self.subModelType = car?.subModelType
        makeCellsViewModel()
    }
    
    // MARK: - Make cells view model
    private func makeCellsViewModel() {
        // for internal methods
        let makeCompanyCellViewModel = CarDetailInfoCellViewModel(value: self.makeCompany, cellType: .makeCompany)
        let modelTypeCellViewModel = CarDetailInfoCellViewModel(value: self.modelType, cellType: .modelType)
        let yearProductionCellViewModel = CarDetailInfoCellViewModel(value: self.yearProduction, cellType: .yearProduction)
        let classTypeCellViewModel = CarDetailInfoCellViewModel(value: self.classType, cellType: .classType)
        let subModelCellViewModel = CarDetailSubModelCellViewModel(value: self.subModelType)
        let deleteCarCellViewModel = CarDetailDeleteCellViewModel(value: "Delete Car")
        
        subModelCellViewModel.onDidChangedSubModelState = { [unowned self] in
            self.changeSubModel()
        }
        
        deleteCarCellViewModel.deleteRequestBlock = { [unowned self] in
            self.deleteCar()
        }
        
        carsCellsViewModels.append(makeCompanyCellViewModel)
        carsCellsViewModels.append(modelTypeCellViewModel)
        carsCellsViewModels.append(yearProductionCellViewModel)
        carsCellsViewModels.append(classTypeCellViewModel)
        carsCellsViewModels.append(subModelCellViewModel)
        if self.car?.id != nil {
            carsCellsViewModels.append(deleteCarCellViewModel)
        }
        
        for value in (0...carsCellsViewModels.count) {
            guard let detailViewModel = carsCellsViewModels[value] as? CarDetailInfoCellViewModel else { break }
            detailViewModel.onDidTapReturnButton = { [] in
                let nextValue = value + 1
                self.onDidRequestTapBlock?(nextValue)
            }
        }
        
        onDidUpdateDataSourceBlock = { [unowned self] in
            self.makeCompany = makeCompanyCellViewModel.value
            self.modelType = modelTypeCellViewModel.value
            self.yearProduction = yearProductionCellViewModel.value
            self.classType = classTypeCellViewModel.value
        }
        
        onDidUpdateSubModelBlock = { [unowned self] value in
            self.subModelType = value
            subModelCellViewModel.value = self.subModelType
        }
        
        onDidChangeSubModelBlock = { [unowned self] in
            self.delegate?.carDetailViewModelDidReqestShowSubModelPicker(self)
        }
    }
    
     // MARK: - Methods CarDetailViewModelProtocol
    func detailTableCellViewModel(forIndexPath indexPath: IndexPath) -> CarDetailTableCellViewModelProtocol? {
        
        return carsCellsViewModels[indexPath.row]
    }
    
    func modelCar() -> String {
        return "modelCar"
    }
    
    // MARK: - Bind to viewController
    func changeSubModel() {
        onDidChangeSubModelBlock?()
    }
    
    func deleteCar() {
        onDidRequestOfDeleteBlock?()
    }
    
    func getRequestDelete() {
        delegate?.carDetailViewModel(self, didDeleteCar: self.car)
    }
    
    func saveCar() {
        onDidUpdateDataSourceBlock?()
        delegate?.carDetailViewModel(self, didSaveCar: self.updateCar())
    }
    
    func updateSubModel(subModel: String?) {
        onDidUpdateSubModelBlock?(subModel)
    }
    
    func updateCar() -> Car? {
        self.car?.classType = self.classType
        self.car?.makeCompany = self.makeCompany
        self.car?.modelType = self.modelType
        self.car?.subModelType = self.subModelType
        self.car?.yearProduction = Int(self.yearProduction ?? "")
        if car?.id == nil {
            car?.id =  UUID().uuidString
        }
        return self.car
    }
}
