//
//  PersonalProductCell.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/06/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import Kingfisher

protocol ActivationDelegate {
    func didTapAt(indexPath: IndexPath?)
}

class PersonalProductCell: UITableViewCell {
    
    // MARK:- Properties
    var delegate: ActivationDelegate?
    var indexPath: IndexPath?
    
    // MARK:- IBOutlets
    @IBOutlet weak var personalProductImage: UIImageView?
    @IBOutlet weak var personalProductTitle: UILabel?
    @IBOutlet weak var personalProductDescription: UILabel?
    @IBOutlet weak var personalProductValue: UILabel?
    @IBOutlet weak var activationButton: UIButton?
    @IBOutlet weak var personalCardView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        activationButton?.layer.cornerRadius = 8
        activationButton?.clipsToBounds = true
        personalCardView?.layer.cornerRadius = 20
        personalCardView?.clipsToBounds = true
        personalCardView?.backgroundColor = .quaternarySystemFill
        personalProductImage?.contentMode = .scaleAspectFit
        personalProductValue?.textColor = .systemYellow
    }
    
    func setCellWith(forIndex index: IndexPath,
                     title: String, withDescription description: String,
                     withImage image: String, andWithPrice price: String,
                     activated: Bool) {
        indexPath = index
        personalProductTitle?.text = title
        personalProductDescription?.text = description
        personalProductValue?.text = price
        
        if activated {
            activationButton?.backgroundColor = .red
            activationButton?.setTitle("Deactivate ad", for: .normal)
        } else {
            activationButton?.backgroundColor = .yellow
            activationButton?.setTitle("Activate ad", for: .normal)
        }
        
        guard let url = URL(string: image) else { return }
        personalProductImage?.kf.indicatorType = .activity
        personalProductImage?.kf.setImage(with: url)
    }
    
    @IBAction func didTapActivationButton(_ sender: UIButton) {
        delegate?.didTapAt(indexPath: indexPath)
    }
    
}
