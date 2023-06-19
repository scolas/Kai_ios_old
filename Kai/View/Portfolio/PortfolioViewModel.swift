//
//  PortfolioViewModel.swift
//  Kai
//
//  Created by Scott Colas on 2/13/22.
//

import Foundation

final class PortfolioViewModel: ObservableObject{
    @Published var properties: [Property] = []
    private var model: [Property] = []
    //for image of cell https://www.youtube.com/watch?v=CimY_Sr3gWw&ab_channel=iOSAcademy
    
    func getProperties(for username: String){
        //Network calls
        
        //mock
        self.properties = MockData.properties
        var allPosts: [Property] = []
        //var allPosts: [property: Property] = []

        DatabaseManager.shared.properties(for: username) {[weak self] result in
            DispatchQueue.main.async {
              

                switch result {
                case .success(let posts):
                    //allPosts.append(contentsOf: posts.map($0.data()))
                    allPosts.append(contentsOf: posts.compactMap({
                        ($0)
                    }))
                    self?.properties = allPosts
                case .failure:
                    break
                }
            }
        }
        
    
       
    }
    
    func getMockProperties(for username: String){
        //Network calls
        
        //mock
        self.properties = MockData.properties
        var allPosts: [Property] = []
        //var allPosts: [property: Property] = []


        
    
       
    }
    
    

}
