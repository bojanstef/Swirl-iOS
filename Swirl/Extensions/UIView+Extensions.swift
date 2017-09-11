//
//  UIView+Extensions.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/10/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

extension UIView {
    func loadNib(completion: ((UIView) -> Void)) {
        let nibName = String(describing: type(of: self))
        guard let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else { return }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutAttachAll(to: self)
        completion(view)
    }
}

fileprivate extension UIView {
    func layoutAttachAll(to view: UIView) {
        view.addConstraint(equalConstraint(view: view, attribute: .top))
        view.addConstraint(equalConstraint(view: view, attribute: .bottom))
        view.addConstraint(equalConstraint(view: view, attribute: .left))
        view.addConstraint(equalConstraint(view: view, attribute: .right))
    }

    func equalConstraint(view: UIView, attribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal,
                                  toItem: self, attribute: attribute, multiplier: 1, constant: 0)
    }
}
