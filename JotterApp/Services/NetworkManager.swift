//
//  NetworkManager.swift
//  JotterApp
//
//  Created by cr3w on 09.03.2021.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    public var dataTask: URLSessionDataTask?
    
    private init() {}
    
    func getData(completion: @escaping (Data?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        guard let url = URL(string: Url.get.rawValue + "\(20)" ) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
                        
        dataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                guard let data = data else { return }
                completion(data)
            }
            else {
                print("URLSession error: \(error!.localizedDescription)")
            }
        })
        dataTask?.resume()
        session.finishTasksAndInvalidate()
    }
}
