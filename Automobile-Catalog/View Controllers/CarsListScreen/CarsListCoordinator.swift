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
        let controller = CarsListController(viewModel: carsViewModel)
        navigationController?.pushViewController(controller, animated: false)
        controller.navigationItem.rightBarButtonItem = controller.barButtonItem(buttonType: .add)
        controller.navigationItem.title = "Contact List"
    }
}
