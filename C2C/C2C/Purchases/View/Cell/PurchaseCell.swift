//
//  PurchaseCell.swift
//  C2C
//
//  Created by Guilherme Paciulli on 23/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class PurchaseCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView?
    @IBOutlet weak var productImage: UIImageView?
    @IBOutlet weak var productTitle: UILabel?
    @IBOutlet weak var purchaseStatus: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView?.layer.cornerRadius = 20
        cardView?.clipsToBounds = true
        purchaseStatus?.textColor = .systemYellow
    }
    
    func configureCell(withProductName name: String, andStatus status: String) -> UIImageView? {
        productTitle?.text = name
        purchaseStatus?.text = status
        return productImage
    }

}
