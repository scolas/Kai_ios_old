//
//  Tenate.swift
//  realEstate
//
//  Created by Scott Colas on 1/2/22.
//

import Foundation
struct Tenant: Codable {
    let identifer: String
    let name: String
    let address: String
    let unit: Int
    let rent: Int
    let moveInDate: Date
    let propertyId: String
  //  let username: String
  //  let dateString: String
//    let postId: String?
 //   let postUrl: String?
}
