//
//  PropertyDetailViewModel.swift
//  Kai
//
//  Created by Scott Colas on 2/25/22.
//

import Foundation
//
//  PortfolioViewModel.swift
//  Kai
//
//  Created by Scott Colas on 2/13/22.
//


final class PropertyDetailViewModel: ObservableObject{
    @Published var tenant: [Tenant] = []
  //  @Published var property: Property?
    
    //private var model: [Tenant] = []
    //for image of cell https://www.youtube.com/watch?v=CimY_Sr3gWw&ab_channel=iOSAcademy
    
    
    func fetchPropertyInfo(id: String, username: String) {

        
        // mock data
        var username = "owner"
        DatabaseManager.shared.getProperty(with: id, from: username) { [weak self] propertydb in
            guard let propertytmp = propertydb else {
                return
            }
            //id = propertydb?.identifer
            //addresstmp = propertydb?.address
            //nametmp = propertydb?.name
            
        }
        


        
    }
    func fetchTenantInfo(id: String, username: String){
        //var allTenants: [(tenant: Tenant, owner: String)] = []
        var allTenants: [Tenant] = []
     
        let username = UserDefaults.standard.string(forKey:"username") ?? "User"
        DatabaseManager.shared.tenants(for: username) { result in
            DispatchQueue.main.async {
             

                switch result {
                case .success(let posts):
                    allTenants.append(contentsOf: posts.compactMap({
                        //(tenant: $0, owner: "mrcolas")
                        ($0)

                    }))
                    self.tenant = allTenants
                case .failure:
                    break
                }
            }
        }
        

    
    }
    
    

}
