//
//  UITextField+ClearButton.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    // MARK: - Clear data
    func clearButtonWithImage(_ image: UIImage) {
        let clearButton = UIButton()
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(self.clear(sender:)), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }
    
    @objc func clear(sender: AnyObject) {
        self.text = ""
    }
}
