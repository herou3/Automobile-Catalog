//
//  SubModelPickerViewModelProtocol.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 17.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation

protocol SubModelPickerViewModelProtocol: class {
    
    var numberOfRows: Int { get }
    
    func subModelValue(forRow row: Int) -> String?
    
    func saveSubModelValue(_ soundValue: String)
}
