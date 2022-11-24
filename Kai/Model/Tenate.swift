//
//  Tenate.swift
//  realEstate
//
//  Created by Scott Colas on 1/2/22.
//

import Foundation
// handel edge cases when no apartment is assigned 
//struct Tenant: Codable {
struct Tenant: Codable,Identifiable {
    let id: String
    let name: String
    let address: String
    let unit: Int
    let rent: Int
    let moveInDate: Date
    let propertyId: String
    let identifer: String
    let apartmentId: Int
    let apartment: Apartment
  //  let username: String
  //  let dateString: String
//    let postId: String?
 //   let postUrl: String?
}



struct MockTenantData{
    static let tenants = [mockTenant,mockTenant,mockTenant]
    
    static let mockTenant = Tenant(
        id: "1",
        name: "James",
        address: "123 car drive Utah",
        unit: 1,
        rent: 2300,
        moveInDate: Date(),
        propertyId: "123",
        identifer: "1234",
        apartmentId: 123,
        apartment: MockApartmentData.mockApartment
    )
}
