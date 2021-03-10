//
//  MainAlertVC.swift
//  JotterApp
//
//  Created by cr3w on 10.03.2021.
//

import UIKit

extension MainViewController {
    func showAlertView(phone: String) {
        let alertVC = UIAlertController(title: "Call to \(phone)", message: nil, preferredStyle: .alert)
        let callAction = UIAlertAction(title: "Call", style: .default) { (_) in
            print("calling to \(phone)")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(callAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true)
    }
}
