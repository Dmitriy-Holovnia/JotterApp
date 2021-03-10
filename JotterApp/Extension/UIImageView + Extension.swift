//
//  UIImageView + Extension.swift
//  JotterApp
//
//  Created by cr3w on 09.03.2021.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: URL) -> URLSessionDownloadTask? {
        if getCachedImage(url: url) { return nil }
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url) { [weak self] (url, response, error) in
            guard let self = self else { return }
            if error == nil,
               let url = url,
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data),
               let response = response {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = image
                }
                self.saveImageToCache(data: data, url: url, response: response)
            }
        }
        downloadTask.resume()
        return downloadTask
    }
    
    func fetchImage(with url: URL) {
        if getCachedImage(url: url) { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error { print(error.localizedDescription); return }
            guard let response = response,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
            self.saveImageToCache(data: data, url: url, response: response)
            
        }.resume()
    }
    
    private func saveImageToCache(data: Data, url: URL, response: URLResponse) {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: request)
    }
    
    private func getCachedImage(url: URL) -> Bool {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data,
           let image = UIImage(data: data) {
            self.image = image
            return true
        }
        return false
    }
}
