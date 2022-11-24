//
//  FinanceAllView.swift
//  Kai
//
//  Created by Scott Colas on 2/13/22.
//

import SwiftUI

struct FinanceAllView: View {
    var body: some View {
        VStack{
            overviewHeader()
                .frame(width: UIScreen.main.bounds.width-5, height: UIScreen.main.bounds.height/2)
                .background(Color.green)
                .cornerRadius(30)
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                finaceCell()
            }
        }
        
    }
}

struct finaceCell: View {
    var body: some View {
        HStack{
            Image(systemName: "house")
            
            VStack(alignment: .leading, spacing: 5){
                Text("Sanford")
                Text("1200 units")
            }
            Spacer()
            Text("$120,000")
        }
        
    }
}

struct overviewHeader: View {
    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }
    @State private var selectedFlavor: String = ""
    var body: some View {
        VStack{
            /*Picker("Flavor", selection: $selectedFlavor) {
                Text("Chocolate").tag(Flavor.chocolate)
                Text("Vanilla").tag(Flavor.vanilla)
                Text("Strawberry").tag(Flavor.strawberry)
            }*/
            Text(" All property")
            Text("1 Feb 2021 - 28 Feb 2022")
            Text("<  24,500, 000  >")
            VStack{
                HStack{
                    VStack{
                        Text("Cash Flow ")
                        Text("$100,00")
                    }
                    VStack{
                        Text("Cash Flow ")
                        Text("$100,00")
                    }
                }
                HStack{
                    VStack{
                        Text("Cash Flow ")
                        Text("$100,00")
                    }
                    VStack{
                        Text("Cash Flow ")
                        Text("$100,00")
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width-100, height: 100)
            .background(Color.gray)
            .cornerRadius(15)
            
        }
        
    }
}

struct FinanceAllView_Previews: PreviewProvider {
    static var previews: some View {
        FinanceAllView()
    }
}
