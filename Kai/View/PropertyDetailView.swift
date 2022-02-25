//
//  PropertyDetailView.swift
//  Kai
//
//  Created by Scott Colas on 2/12/22.
//

import SwiftUI

struct PropertyDetailView: View {
    var body: some View {
        
        VStack {
            topDetail()
            Spacer()
            midDetail()
            Spacer()
            bottomDetail()
        }
        
    }
}

struct topDetail: View {
    var body: some View{
       
        VStack {
            Image("bigHouse2")
            Text("Sanford")
            
            HStack {
                Label("3000 Units ", image: "house")
                Label("Owned for 12 years", image: "house")
            }
            Text(" 58 Sanford ave Bridgeport CT, 06604-0919")
            
            
        }
    }
    
}

struct midDetail: View {
    var body: some View{
        HStack {
            VStack {
                Text("Expense")
                Text("$5,000.00")
                Text("Income")
                Text("$10,000.00")
                Text("Cash Flow")
                Text("$5,000.00")
            }
            Spacer()
            Circle()
                .size(CGSize(width: 100.0, height: 100.0))
                .frame(width: 150, height: 30, alignment: .center)
                
        }
    }
}


struct bottomDetail: View {
    var body: some View{
        NavigationView{
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/){ item in
                Text("Unit 1")
                Text("Jim char")
                Text("Rent: 5,000")
            }.navigationTitle("Tenants")
        }

        
    }
}


struct PropertyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyDetailView()
    }
}
