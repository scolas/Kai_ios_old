//
//  SplashViewModel.swift
//  Kai
//
//  Created by Scott Colas on 2/8/22.
//

import Foundation
class SplashViewModel: ObservableObject {
    
    /// A plublished property
    @Published private(set) var isLoading: Bool = true
    
    /// Holds home data
    private var model: [Property] = []
    
 
    func fetchData(){
        var allPosts: [Property] = []
        DispatchQueue.main.asyncAfter(deadline: .now()+0.10) {
            self.isLoading = false
        }
        DatabaseManager.shared.properties(for: "mrcolas") { result in
            DispatchQueue.main.async {
              

                switch result {
                case .success(let posts):
                    allPosts.append(contentsOf: posts.compactMap({
                        ($0)
                    }))
                case .failure:
                    break
                }
            }
        }
        model = allPosts
    }
}

