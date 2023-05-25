//
//  SetTenantApartment.swift
//  Kai
//
//  Created by Scott Colas on 12/25/22.
//

import SwiftUI
/*
struct SetTenantApartment: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SetTenantApartment_Previews: PreviewProvider {
    static var previews: some View {
        SetTenantApartment()
    }
}*/
//
//  AddTenantFormView.swift
//  Kai
//
//  Created by Scott Colas on 3/28/22.
//

import SwiftUI
class SetTenantViewModel: ObservableObject{
    @State var name = ""
    @State var property = ""
    @State var unit = ""
    @State var moveInDate = Date()
    @State var Rent = ""
}
private func createNewPostID() -> String? {
    let timeStamp = Date().timeIntervalSince1970
    let randomNumber = Int.random(in: 0...1000)
    guard let username = UserDefaults.standard.string(forKey: "username") else {
        return nil
    }

    return "\(username)_\(randomNumber)_\(timeStamp)"
}

struct SetTenantApartment: View {
    var property: Property
    @State var name: String = ""
    @State var Property: String = ""
    @State var MoveInDate: String = ""
    @State var unitNumber: String = ""
    @State var Rent: String = ""
    @State var insurance: String = ""
    @State var taxes: String = ""
    @State private var emailFieldIsFocused: Bool = false
    @State private var searchValue: String = ""
    @StateObject var viewModel = FormViewModel()
    
/*
    var id: String
    let property: Property
    let name: String
    let address: String
    let unit: Int
    let rent: Int
    let moveInDate: Date
    let propertyId: String
    let identifer: String
    let apartmentId: Int
    let tenantEmail: String
}*/
    
    var body: some View {
       
        
        NavigationView{
            VStack{
                Text("Complete your Apartment data")
                Text("add start management")
                Form{
                    Section(header: Text("Name")){
                        TextField("Name", text:$name)
                            //.padding()
                            .foregroundColor(Color.grayTxt)
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .listRowBackground(Color.addTextfield)
                    }
                    .foregroundColor(.black)
                    
                    Section(header: Text("Property")){
                        TextField("Property", text:$viewModel.property)
                            .listRowBackground(Color.addTextfield)
                    }
                    .foregroundColor(.black)
                    Section(header:Text("Move in Date")){
                        DatePicker("Date", selection: $viewModel.moveInDate, displayedComponents: .date)
                            .listRowBackground(Color.addTextfield)
                    }
                    .foregroundColor(.black)
                    
                    Section(header:Text("Unit Number")){
                        TextField("Unit", text:$viewModel.unit)
                            .listRowBackground(Color.addTextfield)
                    }
                    .foregroundColor(.black)
        
                    Section(header: Text("Rent")){
                        TextField("Rent", text:$viewModel.Rent)
                            .listRowBackground(Color.addTextfield)
                    }
                    .foregroundColor(.black)
                }
                .background(Color.white)
                .onAppear { // ADD THESE
                  UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                  UITableView.appearance().backgroundColor = .systemGroupedBackground
                }

                Button(action: {
                    guard !name.isEmpty, !name.isEmpty else {
                        return
                    }
                  /*  let tmpProp = Property(
                        id: "",
                        name: name,
                        image: "",
                        units: Int(unitNumber) ?? 0,
                        owned: "",
                        address: "address",
                        expense: 0,
                        income: 0,
                        cashflow: 0,
                        taxes: Int(taxes) ?? 0,
                        insurance: Int(insurance) ?? 0,
                        mortgage: 2100
                    )*/
                    //addProperty(property: tmpProp)
                   // var t = tmpProp
                    var t = MockApartmentData.mockApartment
                    var apartmentData = Apartment.init(id: "", property: property, name: name, address: unitNumber, unit: Int(unitNumber) ?? 0, rent: Int(Rent) ?? 0, moveInDate: Date.now, propertyId: property.id, identifer: "", apartmentId: "", tenantEmail: "")
                    //print(t)
                   // UserDefaults.standard.setValue("mrcolas", forKey: "username")
                    
                    guard let newPostID = createNewPostID(),
                          let stringDate = String.date(from: Date()) else {
                              return
                          }
                    t.id = newPostID
                   // t.property = property
                    apartmentData.apartmentId = newPostID
                    
                    DatabaseManager.shared.createApartment(newApartment: apartmentData) { finished in
                        guard finished else {
                            return
                        }
                        DispatchQueue.main.async {
                            // presentation.wrappedValue.dismiss()
                            //self.rootPresentationMode.wrappedValue.dismiss()
                        }
                    }
                }, label: {
                    Text("Save")
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.darkGreen)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                })
            }
            
        }
    }
}

struct SetTenantApartment_Previews: PreviewProvider {
    static var previews: some View {
        SetTenantApartment(property: MockData.mockProperty)
    }
}

