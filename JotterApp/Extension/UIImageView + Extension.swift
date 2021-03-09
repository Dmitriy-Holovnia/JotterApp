//
//  UIImageView + Extension.swift
//  JotterApp
//
//  Created by cr3w on 09.03.2021.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url) { [weak self] (url, response, error) in
            guard let self = self else { return }
            if error == nil,
               let url = url,
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = image
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
