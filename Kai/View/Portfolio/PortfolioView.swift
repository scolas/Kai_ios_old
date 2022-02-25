//
//  PortfolioView.swift
//  Kai
//
//  Created by Scott Colas on 2/8/22.
//

import SwiftUI

struct PortfolioView: View {
    /*@ObservedObject  var viewModel = PortfolioViewModel()
    var body: some View {
        VStack {
            //topBar()
            //Spacer()
            cardProperty(vm: viewModel)
                .onAppear{viewModel.getProperties()}
        }
        
    }*/
    //@ObservedObject var vm: PortfolioViewModel()
    @ObservedObject  var viewModel = PortfolioViewModel()
    @State private var isActive : Bool = false
    @State var isNavigationBarHidden: Bool = true
    var body: some View{
        NavigationView{
            VStack{
                miniTopBar()
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                List(viewModel.properties, id: \.id) { property in
                    propertyCell(propety: property)
                }.onAppear{viewModel.getProperties()}
                
                NavigationLink("Add Property",destination: AddPropertyView(), isActive: self.$isActive )
                    .isDetailLink(false)
                    .foregroundColor(.red)
                
                
            }
            .navigationBarTitle("Portfolio")
            .navigationBarHidden(self.isNavigationBarHidden)
            .onAppear {
                self.isNavigationBarHidden = true
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentationMode, self.$isActive)
        
    }
}
struct cardProperty: View {
    @ObservedObject var vm: PortfolioViewModel
    @State private var isActive : Bool = false
    var body: some View{
       // NavigationView{
        
            List(vm.properties, id: \.id) { property in
                propertyCell(propety: property)
            }
        NavigationLink("add property", destination: AddPropertyView() , isActive: self.$isActive )
            .isDetailLink(false)
        .navigationViewStyle(StackNavigationViewStyle())
                .environment(\.rootPresentationMode, self.$isActive)
         //.onAppear{vm.getProperties()}
        //NavigationLink("add property", destination: AddPropertyView())
        
               //RoundedRectangle(cornerSize: 16)
    }
}


struct propertyCell: View {
    let propety: Property
    var view = UILabel()

  
   
   
    var body: some View{
        VStack {
            Image("tableProp")
            Text(propety.name)
                .frame(width: UIScreen.main.bounds.width-90, height: 24, alignment: .leading)
            HStack{
                Label {
                    Text(propety.address)
                        .font(.custom("Poppins-Regular", size: 12))
                        .frame( height: 15)
                        .foregroundColor(Color.grayTxt)
                } icon: {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black)
                }.padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 0))
                Spacer()
                Label {
                    Text(String(propety.units)+"units")
                        .font(.custom("Poppins-Regular", size: 12))
                        //.frame(width: 76, height: 15)
                        //.fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.grayTxt)
                } icon: {
                    Image(systemName: "building.2")
                        .foregroundColor(Color.black)
                        .font(.system(size: 12))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}
struct miniTopBar: View {
    @State private var searchValue: String = ""
    @StateObject  var viewModel = PortfolioViewModel()
    let username = UserDefaults.standard.string(forKey:"username") ?? "User"
    
    var body: some View{
        var tmp = viewModel.properties
        
        VStack {
            HStack {
                Image("person1")
                    .padding()
                Spacer()
                VStack {
                    Text("Hi,\(username)" )
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                    Text("you have 100 property")
                }.foregroundColor(.white)
                .padding()
                Spacer()
                Image(systemName: "message")
                    .padding()
                    .foregroundColor(.white)
            }
            

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                TextField("Search",
                          text: $searchValue)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
            }
            .padding()
                .background(Capsule().fill(Color.medGreen))
              //.textFieldStyle(OvalTextFieldStyle())
                .padding()
        }
        
        .background(Color.darkGreen)
        .cornerRadius(15)
  
        
        
    }
}
struct topBar: View {
    @State private var searchValue: String = ""
    @StateObject  var viewModel = PortfolioViewModel()
   
    var body: some View{
        var tmp = viewModel.properties
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.green)
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width-5, height: UIScreen.main.bounds.height/2)
            VStack {
                HStack {
                    Image("person1")
                    
                    VStack {
                        Text("Hi, Sarah")
                        Text("you have 100 property")
                    }
                    Image(systemName: "message")
                    NavigationLink("add property", destination: AddPropertyView())
                }
               
                HStack {
                    TextField("Search...", text: $searchValue)
                }
                .textFieldStyle(OvalTextFieldStyle())
                Text("Recent Property")
                HStack{
                    recentProperty(recentPropety: tmp.first ?? MockData.mockProperty)
                    recentProperty(recentPropety: tmp.first ?? MockData.mockProperty )
                   
                }
                    
            }
        }
    }
}

struct recentProperty: View {
    var recentPropety: Property
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.red)
                .frame(width: 200, height: 250)
            VStack {
                Image("portfolioHouse1")
                Text(recentPropety.name)
                Label(recentPropety.address, image: "house")
                Label(String(recentPropety.units)+"units", image: "house")
                
            }
        }
    }
}


struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.medGreen, Color.medGreen]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            
    }
}
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
