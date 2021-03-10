//
//  UserTableViewCell.swift
//  JotterApp
//
//  Created by cr3w on 09.03.2021.
//

import UIKit

protocol AlertDelegate: class {
    func onLabelTap(text: String)
}

class UserTableViewCell: UITableViewCell {
    
    static var id: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: id, bundle: nil)}
    private var downloadTask: URLSessionDownloadTask?
    weak var delegate: AlertDelegate?
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var photoIcon: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    public func configureCell(_ result: Result) {
        self.setupUI()
        self.nameLabel.text = result.name.first
        self.surnameLabel.text = result.name.last
        self.phoneLabel.text = result.phone
        if let mediumUrl = result.picture.medium, let url = URL(string: mediumUrl) {
            downloadTask = photoView.loadImage(url: url)
        }
    }
    
    public func setupUI() {
        photoView.layer.borderWidth = 1
        photoView.layer.cornerRadius = photoView.frame.height / 2
        photoView.clipsToBounds = true
        
        photoIcon.image = UIImage(systemName: "phone.fill")
        photoView.contentMode = .scaleAspectFit
        photoView.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(makeCall))
        phoneLabel.addGestureRecognizer(tapGesture)
        phoneLabel.isUserInteractionEnabled = true
    }
    
    @objc private func makeCall() {
        guard let phone = phoneLabel.text else { return }
        delegate?.onLabelTap(text: phone)
    }
}
