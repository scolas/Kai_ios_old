//
//  TabBarTenantView.swift
//  Kai
//
//  Created by Scott Colas on 11/24/22.
//

import SwiftUI

struct TabBarTenantView: View {
    var TenantModel = MockTenantData.mockTenant
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
                    
                    
                    NavigationLink(destination: PayRent(payment: MockPaymentData.mockPayment)) {
                        Button("$ Make a payment") {
                            print("Button pressed!")
                        }
                        .padding()
                        .foregroundColor(.black)
                        .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(red: 0.906, green: 0.937, blue: 0.929))
                        .clipShape(Capsule())
                    }
               
                }
                
            }
            

        }
    }
}

struct TabBarTenantView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarTenantView()
    }
}
