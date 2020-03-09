//
//  ProductCell.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var cardView: UIView?
    @IBOutlet weak var productTitle: UILabel?
    @IBOutlet weak var productImage: UIImageView?
    @IBOutlet weak var productDescription: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cardView?.layer.cornerRadius = 20
        cardView?.clipsToBounds = true
        cardView?.backgroundColor = .quaternarySystemFill
        productImage?.contentMode = .scaleAspectFit
    }
    
    func setCellWith(title: String, withDescription description: String, andWith image: String) {
        productTitle?.text = title
        productDescription?.text = description
        guard let url = URL(string: image) else { return }
        productImage?.kf.setImage(with: url)
    }
    
}
