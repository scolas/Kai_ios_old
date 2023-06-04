//
//  ContentView.swift
//  Kai
//
//  Created by Scott Colas on 2/5/22.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject private var viewModel = SplashViewModel()
    let bgcolor: UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    
    @State var animate: Bool = false
    var body: some View {
        Group {
            if self.viewModel.isLoading {
                //PortfolioView()
                //SignUpView()
                ContentView()
            }else{
                VStack{
                    ZStack{
                        //content
                        ZStack{
                            Text("House")
                            
                        }
                        //splash
                        // make more space between Kai and house
                        ZStack {
                            
                            Color(bgcolor)
                            VStack {
                                Spacer()
                                Text("Kai")
                                    .font(.system(size: 36, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                                    .scaleEffect(animate ? 5 :1 )
                                    .animation(Animation.easeIn(duration: 2))
                                  
                                Image("splashHouse")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    
                            }
                           
                          
                        }
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    }
                    
                }.onAppear{
                    self.viewModel.fetchData()
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
