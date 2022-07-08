//
//  AddTenantFormView.swift
//  Kai
//
//  Created by Scott Colas on 3/28/22.
//

import SwiftUI
class FormViewModel: ObservableObject{
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

struct AddTenantFormView: View {
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
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Complete your Tenant data")
                Text("add start management")
                Form{
                    Section(header: Text("Name")){
                        TextField("Name", text:$viewModel.name)
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
                    let tmpProp = Kai.Property(
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
                        insurance: Int(insurance) ?? 0
                    )
                    //addProperty(property: tmpProp)
                    var t = tmpProp
                    print(t)
                    UserDefaults.standard.setValue("mrcolas", forKey: "username")
                    
                    guard let newPostID = createNewPostID(),
                          let stringDate = String.date(from: Date()) else {
                              return
                          }
                    t.id = newPostID
                    DatabaseManager.shared.createProperty(newProperty: t) { finished in
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

struct AddTenantFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTenantFormView()
    }
}
