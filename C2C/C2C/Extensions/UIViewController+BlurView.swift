//
//  UIViewController+BlurView.swift
//  C2C
//
//  Created by Guilherme Paciulli on 20/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

private var loadingView: UIView?

extension UIViewController {
    func showSpinnerView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        let spinnerView: UIVisualEffectView = .init(frame: view.bounds)
        spinnerView.effect = UIBlurEffect(style: .systemChromeMaterial)

        let activityIndicatorView: UIActivityIndicatorView = .init(style: .medium)
        activityIndicatorView.startAnimating()
        activityIndicatorView.center = spinnerView.center
        
        DispatchQueue.main.async { [weak self] in
            spinnerView.contentView.addSubview(activityIndicatorView)
            self?.view?.addSubview(spinnerView)
        }
        
        loadingView = spinnerView
    }
    
    func removeSpinnerView() {
        DispatchQueue.main.async {
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }
}
