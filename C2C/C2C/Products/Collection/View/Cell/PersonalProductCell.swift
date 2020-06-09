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
        personalProductImage?.contentMode = .scaleAspectFill
    }
    
    func setCellWith(forIndex index: IndexPath, title: String, withImage image: String, activated: Bool) {
        indexPath = index
        personalProductTitle?.text = title
       
        if activated {
            activationButton?.backgroundColor = .red
            activationButton?.setTitle("Deactivate", for: .normal)
        } else {
            activationButton?.backgroundColor = .yellow
            activationButton?.setTitle("Activate", for: .normal)
        }
        
        guard let url = URL(string: image) else { return }
        personalProductImage?.kf.indicatorType = .activity
        personalProductImage?.kf.setImage(with: url)
    }
    
    @IBAction func didTapActivationButton(_ sender: UIButton) {
        delegate?.didTapAt(indexPath: indexPath)
    }
    
}
