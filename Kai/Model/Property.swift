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
    let mortgage: Int
}


struct MockData{
    static let properties = [mockProperty,mockProperty1,mockProperty2]
    
    static let mockProperty = Property(
        id: "1",
        name: "Sanford",
        image: "",
        units: 15,
        owned: "Owned for 12 years",
        address: "58 Sanford ave Bridgeport ct",
        expense: 1200,
        income: 55000,
        cashflow: 50000,
        taxes: 5,
        insurance: 5,
        mortgage: 1200
    )
    
    static let mockProperty1 = Property(
        id: "2",
        name: "State st",
        image: "",
        units: 3,
        owned: "Owned for 3 years",
        address: "123 State ave New Haven CT",
        expense: 888,
        income: 1234,
        cashflow: 7000,
        taxes: 900,
        insurance: 500,
        mortgage: 2200
    )
    
    static let mockProperty2 = Property(
        id: "3",
        name: "Madison ave",
        image: "",
        units: 330,
        owned: "Owned for 20 years",
        address: "123 Madison ave New York City NY",
        expense: 300000,
        income: 2850000,
        cashflow: 2300000,
        taxes: 20000,
        insurance: 12000,
        mortgage: 15000
    )
}
