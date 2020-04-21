//
//  CreditCard+TextFieldDelegate.swift
//  C2C
//
//  Created by Guilherme Paciulli on 12/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

extension CreditCardViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return expirationDateSource.numberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return expirationDateSource.numberOfItems(inComponent: component)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return expirationDateSource.get(component, atIndex: row)
    }
    
}
