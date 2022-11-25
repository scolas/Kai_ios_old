//
//  Apartment.swift
//  Kai
//
//  Created by Scott Colas on 11/24/22.
//

import Foundation

struct Apartment: Codable,Identifiable {
    let id: String
    let property: Property
    let name: String
    let address: String
    let unit: Int
    let rent: Int
    let moveInDate: Date
    let propertyId: String
    let identifer: String
    let apartmentId: Int
}


struct MockApartmentData{
    static let apartments = [mockApartment,mockApartment,mockApartment]
    
    static let mockApartment = Apartment(
        id: "1",
        property: MockData.mockProperty,
        name: "James",
        address: "123 car drive Utah",
        unit: 1,
        rent: 2300,
        moveInDate: Date(),
        propertyId: "123",
        identifer: "1234",
        apartmentId: 123
    )
}
