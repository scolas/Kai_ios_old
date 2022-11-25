//
//  AddTenantView.swift
//  Kai
//
//  Created by Scott Colas on 3/27/22.
//
import Combine
import SwiftUI



private func createNewPostID() -> String? {
    let timeStamp = Date().timeIntervalSince1970
    let randomNumber = Int.random(in: 0...1000)
    guard let username = UserDefaults.standard.string(forKey: "username") else {
        return nil
    }

    return "\(username)_\(randomNumber)_\(timeStamp)"
}


    func addTenant(property: Property){
        var t = property
        print(t)
 

  
        UserDefaults.standard.setValue("mrcolas", forKey: "username")

        // Generate post ID
        guard let newPostID = createNewPostID(),
              let stringDate = String.date(from: Date()) else {
            return
        }
        t.id = newPostID
       /* // Upload Post
        StorageManager.shared.uploadPost(
            data: image.pngData(),
            id: newPostID
        ) { newPostDownloadURL in
            guard let url = newPostDownloadURL else {
                print("error: failed to upload")
                return
            }*/

            // New Post
  

            // Update Database
        DatabaseManager.shared.createProperty(newProperty: t) { finished in
                guard finished else {
                    return
                }
                DispatchQueue.main.async {
                   // presentation.wrappedValue.dismiss()
                    
                }
            }

    }
    
 
struct AddTenantView: View {
    @State var name: String = ""
    @State var Property: String = ""
    @State var MoveInDate: String = ""
    @State var unitNumber: String = ""
    @State var Rent: String = ""
    @State var insurance: String = ""
    @State var taxes: String = ""
    @State private var emailFieldIsFocused: Bool = false
    @State private var searchValue: String = ""
    
    var body: some View {
        
        ScrollView(.vertical){
            Text("Complete your Tenant data")
            Text("and start management")
            VStack{
                VStack{
                    
                    //Group{
                    
                    
                    
                    HStack{
                        Text("Name")
                        Spacer()
                        
                    }
                    
                    TextField("Name",text:$name)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 100).fill(Color.addTextfield))
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.addTextfield,lineWidth: 1)
                            
                        )
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    // .foregroundColor(.black)
                    //
                    //.background(Capsule().fill(Color.addTextfield))
                    HStack{
                        Text("Porperty")
                        Spacer()
                        
                    }
                    
                    TextField("Property",text:$Property)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 100).fill(Color.addTextfield))
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.addTextfield,lineWidth: 1)
                            
                        )
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    HStack{
                        VStack{
                            HStack{
                                Text("Move in Date")
                                Spacer()
                                
                            }
                            TextField("Select Date",text:$MoveInDate)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 100).fill(Color.addTextfield))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color.addTextfield,lineWidth: 1)
                                    
                                )
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .frame(width: 150, height: 44)
                        }
                        
                        VStack{
                            HStack{
                                Text("Unit Number")
                                Spacer()
                                
                            }
                            TextField("Unit Number",text:$unitNumber)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 100).fill(Color.addTextfield))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color.addTextfield,lineWidth: 1)
                                    
                                )
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .frame(width: 150, height: 44)
                                .onReceive(Just(unitNumber)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.unitNumber = filtered
                                    }
                                }
                        }
                    }
                    HStack{
                        Text("Rent")
                        Spacer()
                    }
                    TextField("Rent",text:$Rent)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .keyboardType(.numberPad)
                        .background(Capsule().fill(Color.addTextfield))
                        .onReceive(Just(Rent)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.Rent = filtered
                            }
                        }
                    
                    
                }

                
                        
                
            }
            .navigationTitle("Add Property")
            .frame(width: 350, height: 446, alignment: .center)
            
            
            
            Button(action: {
                guard !name.isEmpty, !name.isEmpty else {
                    return
                }
                let tmpProp = MockData.mockProperty
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
                    .foregroundColor(.white)
                    .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                    .clipShape(Capsule())
            })
        }
}
}
struct AddTenantView_Previews: PreviewProvider {
    static var previews: some View {
        AddTenantView()
    }
}
