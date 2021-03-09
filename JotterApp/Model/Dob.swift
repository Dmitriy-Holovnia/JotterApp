//
//  Dob.swift
//  JotterApp
//
//  Created by cr3w on 09.03.2021.
//

import Foundation

public struct Dob: Codable, Identifiable {
    public let date: String?
    public let age: Int?
    public var id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
        case age = "age"
    }
}
