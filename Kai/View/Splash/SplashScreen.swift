//
//  SplashScreen.swift
//  Kai
//
//  Created by Scott Colas on 2/8/22.
//

import SwiftUI

struct SplashScreen: View {
    let bgcolor: UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    let borderColor = UIColor(red: 0.906, green: 0.937, blue: 0.929, alpha: 1).cgColor
    var body: some View {
                                //splash
        // make more space between Kai and house
        NavigationView{
                ZStack {
                    Color(bgcolor)
                    VStack {
                        Text("Kai")
                            .font(.system(size: 36, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Text("Enjoy easy management of your property")
                            .font(.system(size: 25, weight: .bold, design: .default))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        NavigationLink(destination: SignUpView()) {
                            Button("Sign Up") {
                                print("Button pressed!")
                            }
                            .padding()
                            .foregroundColor(.black)
                            .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color(red: 0.906, green: 0.937, blue: 0.929))
                            .clipShape(Capsule())
                        }
                        
                      /*  NavigationLink(destination: SignUpView()) {
                                Button(action: {
                                    print("pressed")
                                }) {
                                   
                                    Text("Continue With Google")
                                    .padding()
                                    .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.clear)
                                    .border(Color.white)
                                    .foregroundColor(.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.white, lineWidth: 2)
                                    )
                                
                                }
                                .background(Color.clear) // If you have this
                                .cornerRadius(25)
                                
                        }*/
                        
                      /*  Button(action: {
                            print("pressed")
                        }) {
                           
                            Text("Continue With Facebook")
                            .padding()
                            .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.clear)
                            .border(Color.white)
                            .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2)
                            )
                        
                        }
                        .background(Color.clear) // If you have this
                        .cornerRadius(25)*/
                        
      
                        NavigationLink(
                            destination: ContentView(),
                            label: {
                                Text("Login")
                                .padding()
                                .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.clear)
                                .border(Color.clear)
                                .foregroundColor(.white)
                            })
                    }
                   
                  
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
