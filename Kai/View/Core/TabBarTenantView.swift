//
//  TabBarTenantView.swift
//  Kai
//
//  Created by Scott Colas on 11/24/22.
//

import SwiftUI
struct TabBarTenantView: View {
    var TenantModel = MockTenantData.mockTenant
    @EnvironmentObject var viewModelAuth: AuthManager
    var body: some View {
        
        
        
        NavigationView{
            
            VStack {
                HStack{
            
                Image("bigHouse2")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/5, alignment: .center)
                    .cornerRadius(12)
                    
                    VStack{
                        Text(TenantModel.apartment.property.name)
                        Text(TenantModel.apartment.property.address)
                        Text(String(TenantModel.apartment.unit))
                    }
                }
                VStack{
                    Text("Rent")
                        .font(.system(size: 16))
                    Text(String(TenantModel.apartment.rent))
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(Color.grayTxt)
                    Text("Amount Due December 1st")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(Color.grayTxt)
                    
                    
                    NavigationLink(
                        destination:PayRent(payment:MockPaymentData.mockPayment),
                        label: {
                                Text("$ Make a payment")
                                .padding()
                                .foregroundColor(.black)
                                .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color(red: 0.906, green: 0.937, blue: 0.929))
                                .clipShape(Capsule())
                        }
                    )
                    
                    NavigationLink(
                        destination:PaymentHistory(),
                        label: {
                                Text("Previous payments ")
                                .padding()
                                .foregroundColor(.black)
                                .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color(red: 0.906, green: 0.937, blue: 0.929))
                                .clipShape(Capsule())
                        }
                    )

             
                    
                    Button(action: {
                        //viewModel.signOut()
                        viewModelAuth.signOut()
                    }, label: {
                        Text("Sign out")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .padding()
                    })
                    }
                
            }
            

        }
    }
}

struct TabBarTenantView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            TabBarTenantView()
        } else {
            // Fallback on earlier versions
        }
    }
}
