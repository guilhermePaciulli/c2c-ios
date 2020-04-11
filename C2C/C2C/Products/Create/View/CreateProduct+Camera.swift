//
//  CreateProduct+Camera.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

extension CreateProductViewController: MediaCapturePresentable {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            startSelectingImage(self)
        }
    }
    
    func didSelectImage(_ image: UIImage) {
        productImage?.image = image
        productImage?.contentMode = .scaleAspectFill
    }
    
}
