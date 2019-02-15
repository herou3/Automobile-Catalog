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
    
    func numberOfRows(inSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections() -> Int {
        return 4
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CarsListTableCellViewModelProtocol? {
        
        return nil
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        
        print("gds")
    }
    
    func showNewCarViewController() {
        print("Show")
    }
    

}
