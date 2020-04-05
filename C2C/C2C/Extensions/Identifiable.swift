//
//  Identifiable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation
import UIKit

protocol Identifiable: class {}

extension Identifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    static var xibIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func dequeueReusableFooterView<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return headerFooterView
    }
}

extension UITableViewCell: Identifiable {}
extension UIViewController: Identifiable {}
extension UITableViewHeaderFooterView: Identifiable {}
extension UICollectionReusableView: Identifiable {}

extension UIViewController {
    
    static func instantiate<T: UIViewController>() -> T {
        guard let controller = UIStoryboard(name: T.storyboardIdentifier.replacingOccurrences(of: "Controller", with: "").replacingOccurrences(of: "View", with: ""), bundle: T.bundle).instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            // TODO: set crashlytics to warn here
            fatalError("failed to create storyBoard/xib")}
        return controller
    }
    
    static func instantiateFromXIB<T: UIViewController>() -> T {
        return T(nibName: T.xibIdentifier.replacingOccurrences(of: "Controller", with: "").replacingOccurrences(of: "View", with: ""), bundle: .main)
    }
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}
