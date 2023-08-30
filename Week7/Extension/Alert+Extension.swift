//
//  Alert+Extension.swift
//  Week7
//
//  Created by 박소진 on 2023/08/30.
//

import UIKit

extension UIViewController {
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
