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
    
    func startLoading(_ hidingUIElements: Bool = true) {
        showSpinnerView(hidingUIElements)
    }
    
    func startLoading() {
        showSpinnerView()
    }
    
    func stopLoading() {
        removeSpinnerView()
    }
    
    func stopLoading(_ hidingUIElements: Bool = true) {
        removeSpinnerView(hidingUIElements)
    }
    
    func showSpinnerView(_ hidingUIElements: Bool = true) {
        if hidingUIElements {
            navigationController?.setNavigationBarHidden(true, animated: true)
            tabBarController?.tabBar.isHidden = true
        }
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
    
    func removeSpinnerView(_ hidingUIElements: Bool = true) {
        DispatchQueue.main.async {
            if hidingUIElements {
                self.tabBarController?.tabBar.isHidden = true
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }
}
