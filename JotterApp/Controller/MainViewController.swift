//
//  ViewController.swift
//  JotterApp
//
//  Created by cr3w on 09.03.2021.
//

import UIKit

class MainViewController: UIViewController, AlertDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let networkManager = NetworkManager.shared
    private var results: [Result] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        downloadData()
    }
    
    private func setupTableView() {
        tableView.register(UserTableViewCell.nib,
                           forCellReuseIdentifier: UserTableViewCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Constants.rowHeight
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        title = "Jotter"
    }
    
    private func downloadData() {
        DispatchQueue(label: "com.updater.queue", qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.networkManager.getData { (data) in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                guard let result = try? decoder.decode(ResultData.self, from: data) else {
                    return
                }
                self.results += result.results
            }
        }
    }
    
    func onLabelTap(text: String) {
        showAlertView(phone: text)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.id, for: indexPath) as! UserTableViewCell
        let result = results[indexPath.row]
        cell.configureCell(result)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == results.count - 5 {
            downloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = results[indexPath.row]
        let vc = DescriptionViewController(nibName: DescriptionViewController.nib,
                                           bundle: nil)
        vc.setupVC(result)
        navigationController?.pushViewController(vc, animated: true)
    }
}
