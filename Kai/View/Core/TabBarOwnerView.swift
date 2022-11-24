//
//  TabBarOwnerView.swift
//  Kai
//
//  Created by Scott Colas on 11/24/22.
//

import SwiftUI

struct TabBarOwnerView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct Home: View{

    @State var selectedtab = "house"
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    //Location For each Curve...
    @State var xAxis: CGFloat = 0
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedtab){
                PortfolioView()
                    .tabItem{
                        Image(systemName: "house")
                    }
                    .tag("house")
                /*Color.orange
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("house")*/
                FinanceView()
                    .tabItem{
                        Image(systemName: "wallet.pass")
                    }
                    .tag("wallet.pass")
               /* Color.red
                    ignoresSafeArea(.all, edges: .all)
                    .tag("wallet.pass")*/
                /*Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("dollarsign.circle")*/
                TenantHome()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("dollarsign.circle")
                AddPropertyView()
                    .tabItem{
                        Image(systemName: "plus.circle")
                    }
                    .tag("plus.circle")
                /*Color.blue
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("plus.circle")*/
                
            }
            
            // Custom tab Bar...
            HStack(spacing:0){
                ForEach(tabs,id: \.self){image in
                  
                    GeometryReader {reader in
                        Button(action: {
                            withAnimation(.spring()){
                                selectedtab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                            //print(image)
                           // print(selectedtab)
                            Image(systemName: (image))
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedtab == image ? getColor(image: image) : Color.gray)
                                //.padding(selectedtab == image ? 15 : 0)
                                //.padding(selectedtab == "plus.circle" ? 34 : 0 )
                                .background(Color.white.opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                
    //.offset(x:reader.frame(in: .global).minX - reader.frame(in: .global).midX,  y: selectedtab == image ? -50 : 0)
                                
                        })
                            .onAppear(perform: {
                                if image == tabs.first{
                                    //xAxis = reader.frame(in: .global).minX
                                }
                            })
                    }
                    .frame(width: 25, height: 25)
                    // .offset(x:((image == "plus.circle") ? 0 : 25 ), y: 25)
                    if image != tabs.last{Spacer(minLength: 0)}
                }
                
            }
            .padding(.horizontal,30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis,photos: selectedtab)))
            //.background(Color.white)
            
            //curved eedges and float
            //.cornerRadius(12)
            //.padding(.horizontal)
            
            // Bottom Edge...
            //padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    func getColor(image: String)->Color{
        switch image {
        case "house":
            return Color.black
        case "wallet.pass":
            return Color.black
        case "dollarsign.circle":
            return Color.black
        case "plus.circle":
            return Color.green
        default:
            return Color.black
        }
    }
}


var tabs = ["house","wallet.pass","dollarsign.circle","plus.circle"]


struct CustomShape: Shape{
    var xAxis: CGFloat
    var photos: String
    //var xAxis: CGFloat = 335.0
    
    func path(in rect: CGRect) -> Path{
        print("this is xAxis")
        print(xAxis)
        print("this is photos")
        print(photos)
        
        return Path{path in
            path.move(to: CGPoint(x:0, y:0))
            path.addLine(to: CGPoint(x: rect.width,y: 0))
            path.addLine(to: CGPoint(x: rect.width,y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            //let center = rect.width/2
            
            //let center = xAxis
            var center = 335.0
            center = rect.width - 45
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            //let to1 = CGPoint(x: center, y: 35)
            let to1 = CGPoint(x: center, y: 40)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center+25, y: 35)
            let control4 = CGPoint(x: center+25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}



struct TabBarOwnerView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarOwnerView()
    }
}
