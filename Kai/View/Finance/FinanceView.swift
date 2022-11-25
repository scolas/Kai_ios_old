//
//  FinanceView.swift
//  Kai
//
//  Created by Scott Colas on 3/21/22.
//

import SwiftUI
struct Props: Identifiable {
    var id: Int
    
    let name: String
    let units: Int
    let income: Int
}
struct FinanceView: View {
    let  properties: [Props] = [
        .init(id:0,name: "Sanford", units: 3, income: 5000),
        .init(id:1,name: "Congress", units: 6, income: 7000),
        .init(id:2,name: "Laurel", units: 3, income: 5000),
        .init(id:3,name: "Plaza", units: 4, income: 5000),
        .init(id:4,name: "Bank", units: 9, income: 5000),
        .init(id:5,name: "S&J Community", units: 103, income: 50000)
           
    ]

    var body: some View {
        VStack{
            VStack{
                Text("Finance All Property >")
                    .padding(.top,10)
                    //.font(.custom("Poppins-Medium", size: 14))
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .frame(maxWidth: .infinity)
                    .padding()
                Text("1 Sep 2022 - 30 Sep 2022")
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundColor(.grayTxt)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom,2)
                HStack{
                    Text("<")
                        .font(.custom("Poppins-SemiBold", size: 28))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                    Text("$24,000")
                        .font(.custom("Poppins-SemiBold", size: 28))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Text(">")
                        .font(.custom("Poppins-SemiBold", size: 28))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding()
                }

                Text("Rental icome all properties")
                
                HStack(spacing:100){
                    VStack(alignment:.leading){
                        Text("Cash Flow")
                            .padding(.bottom,4)
                        Text("15,000")
                            .padding(.bottom,15)
                       
                        Text("Insurance")
                        Text("2,000")
                            
                    }
                    .padding()
                    
                    VStack(alignment:.leading){
                        Text("Expsense")
                        Text("5,000")
                            .padding(.bottom,15)
                       
                        Text("Tax")
                        Text("1,000")
                    }
                    .padding()
                }
                .font(.custom("Poppins-Medium", size: 16))
                .frame(maxWidth: .infinity,maxHeight: 120)
                .background(Color.medGreen)
                .cornerRadius(20)
                .padding()
                
            }
            .frame(width: UIScreen.Width-15, height: UIScreen.Height/2.2, alignment: .center)
                .foregroundColor(.white)
                .background(Color.darkGreen)
                .cornerRadius(30)
                .padding(EdgeInsets(top: 1, leading: 10, bottom: 0, trailing: 10))
                .padding(.bottom, 12)

            List (properties){ eachProp in
                //ForEach(properties){ eachProp in
                    HStack{
                        Image("HouseIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipped()
                        
                        VStack(alignment: .leading){
                            Text(eachProp.name)
                            Text(String(eachProp.units)+" Units")
                                .font(.system(size: 14, weight: .medium, design: .default))
                            
                        }
                        Spacer()
                        Text(String(eachProp.income))
                    }

                //}
                    
                
            }
            .frame(width: UIScreen.Width, height: UIScreen.Height/2, alignment: .center)
         
        }
        
    }
}

struct FinanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinanceView()
            .background(Color.white)
    }
}
