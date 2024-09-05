//
//  UIControl+Debounce.swift
//  ImagesApp
//
//  Created by don.vo on 9/5/24.
//

import UIKit

extension UIBarButtonItem {
    func debounce(delay seconds: Double = 1) {
        guard let view = self.value(forKey: "view") as? UIView else {
            return
        }

        view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            view.isUserInteractionEnabled = true
        }
    }
}
