//
//  Property.swift
//  Kai
//
//  Created by Scott Colas on 2/8/22.
//

import Foundation

struct Property: Identifiable, Codable {
    var id: String
    var name: String
    var image: String
    var units: Int
    var owned: String
    var address: String
    var expense: Int
    var income: Int
    var cashflow: Int
    var taxes: Int
    var insurance: Int
}


struct MockData{
    static let properties = [mockProperty,mockProperty,mockProperty]
    
    static let mockProperty = Property(
        id: "1",
        name: "Sanford",
        image: "",
        units: 55,
        owned: "Owned for 12 years",
        address: "58 Sanford ave Bridgeport ct",
        expense: 1200,
        income: 55000,
        cashflow: 50000,
        taxes: 5,
        insurance: 5
    )
}
