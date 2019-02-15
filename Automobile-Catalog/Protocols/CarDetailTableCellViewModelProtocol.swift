//
//  CarDetailTableCellViewModelProtocol.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation

protocol  CarDetailTableCellViewModelProtocol {
    
    var value: String? { get set}
    
    func configure(with value: String?)
}
