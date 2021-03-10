//
//  DescriptionViewController.swift
//  JotterApp
//
//  Created by cr3w on 09.03.2021.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    static var nib: String { String(describing: self) }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var genderView: UIImageView!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    public func setupVC(_ result: Result) {
        DispatchQueue.main.async {
            self.setImageView(url: result.picture.medium)
            self.setFullName(result.name)
            self.setGender(result.gender)
            self.setDate(result.dob)
            self.setPhone(result.phone)
        }
    }
    
    // Setup UI
    private func setFullName(_ name: Name) {
        let firstName = name.first ?? ""
        let lastName = name.last ?? ""
        if firstName.isEmpty && lastName.isEmpty {
            fullNameLabel.text = "No name"
        } else {
            fullNameLabel.text =  "\(firstName.uppercased()) \(lastName.uppercased())"
        }
    }
    
    private func setImageView(url: String?) {
        if let imageUrl = URL(string: url!) {
            self.imageView.fetchImage(with: imageUrl)
        }
    }
    
    private func setGender(_ gender: Gender) {
        genderView.image = gender == Gender.male ? #imageLiteral(resourceName: "male") : #imageLiteral(resourceName: "female")
    }
    
    private func setDate(_ date: Dob) {
        let fromFormatter: DateFormatter = .iso8601Full
        let toFormatter: DateFormatter = .ddMMyyyy
        if let raw = date.date,
           let date = fromFormatter.date(from: raw) {
            dobLabel.text = toFormatter.string(from: date)
        } else {
            dobLabel.text = ""
        }
    }
    
    private func setPhone(_ phone: String) {
        let menuInteraction = UIContextMenuInteraction(delegate: self)
        phoneLabel.text = phone
        phoneLabel.isUserInteractionEnabled = true
        phoneLabel.addInteraction(menuInteraction)
    }
}
