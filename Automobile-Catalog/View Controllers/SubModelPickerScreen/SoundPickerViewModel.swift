//
//  SoundPickerViewModel.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 17.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import UIKit

protocol SoundPickerViewModelDelegate: class {
    
    func subModelPickerViewModel(_ viewModel: SubModelPickerViewModel, didSaveSubModel subModelValue: String)
}

class SubModelPickerViewModel: SubModelPickerViewModelProtocol {
    
    // MARK: - Properies
    weak var delegate: SoundPickerViewModelDelegate?
    private let subModelArray: [String?] = ["Sedan",
                                            "SUV",
                                            "Hatchback",
                                            "Estate",
                                            "Minivan",
                                            "Pickup"]
    
    var numberOfRows: Int {
        return subModelArray.count
    }
    
    func subModelValue(forRow row: Int) -> String? {
        
        if row < subModelArray.count && row >= 0 {
            return subModelArray[row]
        } else {
            return "Sedan"
        }
    }
    
    func saveSubModelValue(_ soundValue: String) {
        delegate?.subModelPickerViewModel(self, didSaveSubModel: soundValue)
    }
}
