//
//  File.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func error(text:String) {
        let alertvc = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.show(alertvc, sender: self)
        }
    }
}
