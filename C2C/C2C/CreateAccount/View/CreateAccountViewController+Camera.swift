//
//  CreateAccountViewController+Camera.swift
//  C2C
//
//  Created by Guilherme Paciulli on 05/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

extension CreateAccountViewController: MediaCapturePresentable {
    
    func didSelectImage(_ image: UIImage) {
        profilePicture?.image = image
    }
    
}
