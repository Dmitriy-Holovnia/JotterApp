//
//  DescriptionContextMenu.swift
//  JotterApp
//
//  Created by cr3w on 10.03.2021.
//

import UIKit

extension DescriptionViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let callAction = UIAction(title: "Call", image: nil) { (_) in
            if let _ = URL(string: "tel://4151231234") {
//                 UIApplication.shared.open(url)
                print("make call")
             }
        }
        let copyAction = UIAction(title: "Copy", image: nil) { (_) in
            let text = self.phoneLabel.text ?? ""
            let pasteboard = UIPasteboard.general
            pasteboard.string = text
        }
        let menu = UIMenu(title: "Actions", children: [callAction, copyAction])
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            return menu
        }
        return config
    }
}
