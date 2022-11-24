//
//  PayRent.swift
//  Kai
//
//  Created by Scott Colas on 11/22/22.
//

import SwiftUI

struct PayRent: View {
    var payment: Payment
    var body: some View {
            
        VStack {
            VStack(alignment:.leading){
                    
                Text("Rent")
                Text(String(payment.Amount))
                    .padding(.bottom,15)
                Text("Amount due December 1st")
                                
                 
                        
                   
            }
            .font(.custom("Poppins-Medium", size: 16))
            .frame(maxWidth: .infinity,maxHeight: 120)
            .background(Color(red: 0.906, green: 0.937, blue: 0.929))
            .cornerRadius(20)
            .padding()
            
            
            NavigationLink(destination: SignUpView()) {
                Button("$ Submit payment") {
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

struct PayRent_Previews: PreviewProvider {
    static var previews: some View {
        PayRent(payment: MockPaymentData.mockPayment)
    }
}
