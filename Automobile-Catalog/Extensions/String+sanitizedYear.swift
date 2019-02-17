//
//  String+sanitizedYear.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 16.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation

extension String {
    
    func sanitizedYear() -> String {
        guard !isEmpty else { return self }
        let range = startIndex..<index(startIndex, offsetBy: count)
        return replacingOccurrences(of: "[^+0-9]", with: "",
                                    options: .regularExpression,
                                    range: range)
    }
}
