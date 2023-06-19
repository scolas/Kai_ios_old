//
//  PropertyDetailView.swift
//  Kai
//
//  Created by Scott Colas on 2/12/22.
//

import SwiftUI

struct PropertyDetailView: View {
    var property: Property
    var body: some View {
        
        VStack{
           topDetail(currerntProperty: property)
            
            midDetail(currerntProperty: property)
             /*   .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))*/
        
            // Text("tet")
            
           // bottomDetail(currerntProperty: property)
        }
        .offset(y: -40)
        
    }
    
}


struct topDetail: View {
    var currerntProperty: Property
    var body: some View{
        
        VStack {
            Image("bigHouse2")
                .resizable()
                .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height/3, alignment: .center)
                .cornerRadius(12)
            Text(currerntProperty.name)
                .font(.system(size: 25))
                .frame(width: UIScreen.main.bounds.width-40,alignment:.leading)
            
            HStack {
                Label {
                    Text(String(currerntProperty.units)+" units")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color.grayTxt)
                } icon: {
                    Image(systemName: "building.2")
                        .foregroundColor(Color.black)
                        .font(.system(size: 12))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                
                Label {
                    Text(String(currerntProperty.owned))
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color.grayTxt)
                } icon: {
                    Image(systemName: "calendar")
                        .foregroundColor(Color.black)
                        .font(.system(size: 12))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .frame(width: UIScreen.main.bounds.width-40, alignment: .leading)
            
            HStack{
                Label {
                    Text(currerntProperty.address)
                        .font(.custom("Poppins-Regular", size: 12))
                        .frame( height: 15)
                        .foregroundColor(Color.grayTxt)
                } icon: {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black)
                }.padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 0))
                
            }
            .frame(width: UIScreen.main.bounds.width-40, alignment: .leading)
            
        }
    }
    
}


struct midDetail: View {
    var currerntProperty: Property
    var body: some View{
        NavigationLink("Add Apartment", destination: SetTenantApartment(property: currerntProperty))

        HStack {
            VStack {
                VStack{
                    Text("Expense")
                        .font(.system(size: 16))
                    Text(String(currerntProperty.expense).currencyFormatting())
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(Color.grayTxt)
                        .padding(.bottom, 10)
                }
                
                Text("Income")
                    .font(.system(size: 16))
                Text(String(currerntProperty.income).currencyFormatting())
                    .font(.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color.grayTxt)
                    .padding(.bottom, 10)
                Text("Cash Flow")
                    .font(.system(size: 16))
                Text(String(currerntProperty.cashflow).currencyFormatting())
                    .font(.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color.grayTxt)
                    .padding(.bottom, 10)
            }
            .frame(width: 83, height: 194)
            //.padding(EdgeInsets(top: 0, leading: 90, bottom: 0, trailing: 10))
            //UIScreen.main.bounds.width/2.5, height: //UIScreen.main.bounds.height/3.5
            //width: 83, height: 194
            Spacer()
            Image("chart")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/5)
                .padding()
                
            
        }
        .padding([.top],20)
    }
}


struct bottomDetail: View {
    @ObservedObject  var viewTenantModel = PropertyDetailViewModel()
   /* var ten: [Tenant] = [
        Tenant(id: "1", name: "Paul", address: "Sanford ave", unit: 1, rent: 2000, moveInDate: Date(), propertyId: "1"),
        Tenant(id: "2", name: "Ashley", address: "Sanford ave", unit: 12, rent: 2000, moveInDate: Date(), propertyId: "3"),
        Tenant(id: "1", name: "Kim", address: "Sanford ave", unit: 3, rent: 2000, moveInDate: Date(), propertyId: "1")
        
    ]*/
    var currerntProperty: Property
    var body: some View{
     /*   NavigationView{
            List(ten) { //tenants in
                //Text($0.name)
                Text($0.name)
            }.navigationTitle("ten")
        }  .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height/3, alignment: .center)
        */
        List(viewTenantModel.tenant, id: \.id) { ten in
           // ten.name
            Text(ten.name)
        }.onAppear{viewTenantModel.fetchTenantInfo(id: "1", username: "mrcolas")}
        .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height/3, alignment: .center)
    }
}


struct PropertyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyDetailView(property: MockData.mockProperty)
    }
}
