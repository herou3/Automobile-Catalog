//
//  CarsListCoordinator.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import UIKit

enum ItemButtonType {
    case done
    case close
    case back
    case add
}

final class CarsListCoordinator {

    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    private var changeSubModelBlock: ((_ text: String) -> Void)?
    private var changeCarBlock: ((_ car: Car?) -> Void)?
    private var deleteCarBlock: ((_ car: Car?) -> Void)?

    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.barTintColor = .silver
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func start() {
        showCarList()
    }
    
    // MARK: - Private implementation
    private func showCarList() {
        let carsViewModel = CarsListViewModel()
        carsViewModel.delegate = self
        let controller = CarsListController(viewModel: carsViewModel)
        self.changeCarBlock = { data in
            carsViewModel.updateCar(newCar: data)
            self.navigationController?.popToRootViewController(animated: true)
        }
        self.deleteCarBlock = { data in
            carsViewModel.deleteCar(car: data)
            self.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.pushViewController(controller, animated: false)
        controller.navigationItem.rightBarButtonItem = controller.barButtonItem(buttonType: .add)
        controller.navigationItem.title = "Cars List"
    }
    
    private func showDetailCar(_ car: Car) {
        let viewModel = CarDetailViewModel(car: car)
        viewModel.delegate = self
        let detailController = CarDetailController(viewModel: viewModel)
        self.changeSubModelBlock = { data in
            viewModel.subModelType = data
        }
        detailController.navigationItem.title = viewModel.modelType
        detailController.navigationItem.rightBarButtonItem = detailController.barButtonItem(buttonType: .done)
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    private func showDetailEmptyCar() {
        let emptyDetailEmptyViewModel = CarDetailViewModel(car: Car())
        let detailController = CarDetailController(viewModel: emptyDetailEmptyViewModel)
        emptyDetailEmptyViewModel.delegate = self
        self.changeSubModelBlock = { data in
            emptyDetailEmptyViewModel.subModelType = data
        }
        detailController.navigationItem.rightBarButtonItem = detailController.barButtonItem(buttonType: .done)
        detailController.navigationItem.title = "New Car"
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    private func showSubModelPickerController() {
        let subModelViewModel = SubModelPickerViewModel()
        subModelViewModel.delegate = self
        let subModelController = SubModelPickerController(viewModel: subModelViewModel)
        let navController = UINavigationController(rootViewController: subModelController)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        subModelController.navigationController?.navigationBar.barTintColor = .silver
        subModelController.navigationController?.navigationBar.shadowImage = UIImage()
        subModelController.navigationController?.navigationBar.tintColor = .black
        subModelController.navigationController?.navigationBar.titleTextAttributes = textAttributes
        subModelController.navigationItem.title = "Choose Sub Model"
        subModelController.navigationItem.rightBarButtonItem = subModelController.barButtonItem(type: .done)
        subModelController.navigationItem.leftBarButtonItem = subModelController.barButtonItem(type: .close)
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    private func dismissSoundPickerController(subModel: String) {
        changeSubModelBlock?(subModel)
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension CarsListViewModelDelegate
extension CarsListCoordinator: CarsListViewModelDelegate {
    
    func carListViewModel(_ viewModel: CarsListViewModel, didSelectCar car: Car) {
        showDetailCar(car)
    }
    
    func carListViewModelDidReqestSelectEmptyCar(_ viewModel: CarsListViewModel) {
        showDetailEmptyCar()
    }
}

// MARK: - Extension CarDetailViewModelDelegate
extension CarsListCoordinator: CarDetailViewModelDelegate {
    
    func carDetailViewModelDidReqestShowSubModelPicker(_ viewMidel: CarDetailViewModel) {
        showSubModelPickerController()
    }
    
    func carDetailViewModel(_ viewModel: CarDetailViewModel, didSaveCar car: Car?) {
        changeCarBlock?(car)
    }
    
    func carDetailViewModel(_ viewModel: CarDetailViewModel, didDeleteCar car: Car?) {
        deleteCarBlock?(car)
    }
}

// MARK: - Extension SubModelPickerViewModelDelegate
extension CarsListCoordinator: SoundPickerViewModelDelegate {
 
    func subModelPickerViewModel(_ viewModel: SubModelPickerViewModel, didSaveSubModel subModelValue: String) {
        dismissSoundPickerController(subModel: subModelValue)
    }
}
