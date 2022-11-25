//
//  Payment.swift
//  Kai
//
//  Created by Scott Colas on 11/24/22.
//

import Foundation
struct Payment: Codable,Identifiable {
    let id: String
    let apartment: Apartment
    let Amount: Int
    let Fee: Int
    let apartmentId: String
}


struct MockPaymentData{
    static let Payments = [mockPayment,mockPayment,mockPayment]
    
    static let mockPayment = Payment(
        id: "1",
        apartment: MockApartmentData.mockApartment,
        Amount: MockApartmentData.mockApartment.rent,
        Fee: 50,
        apartmentId: MockApartmentData.mockApartment.id
       
    )
}
