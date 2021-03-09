//
//  Result.swift
//  JotterApp
//
//  Created by cr3w on 09.03.2021.
//

import Foundation

public struct Result: Codable {
    public let name: Name
    public let gender: Gender
    public let dob: Dob
    public let phone: String
    public let picture: Picture
}
