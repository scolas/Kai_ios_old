//
//  AddPropertyView.swift
//  Kai
//
//  Created by Scott Colas on 2/15/22.
//
import Combine
import SwiftUI
struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }

                return AnyView(Color.clear)
            }
        }
    }
}

private func createNewPostID() -> String? {
    let timeStamp = Date().timeIntervalSince1970
    let randomNumber = Int.random(in: 0...1000)
    guard let username = UserDefaults.standard.string(forKey: "username") else {
        return nil
    }

    return "\(username)_\(randomNumber)_\(timeStamp)"
}


    func addProperty(property: Property){
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
    
    func signUp(email: String, password: String){
    }
    

struct AddPropertyView: View {

    /*var body: some View {
        VStack{
            fieldsView()
        }
    }*/
    @State private var isActive : Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State var name: String = ""
    @State var address: String = ""
    @State var purchaseDate: String = ""
    @State var units: String = ""
    @State var Mortgage: String = ""
    @State var insurance: String = ""
    @State var taxes: String = ""
    @State private var emailFieldIsFocused: Bool = false
    @State private var searchValue: String = ""
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                //Group{
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
                    .background(Capsule().fill(Color.addTextfield))
                
                
                TextField("Name",text:$name)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                
                TextField("Address",text:$address)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                TextField("Purchase Date",text:$purchaseDate)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                TextField("Unit",text:$units)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .onReceive(Just(units)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.units = filtered
                        }
                    }
                
                TextField("Mortgage",text:$Mortgage)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .onReceive(Just(Mortgage)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.Mortgage = filtered
                        }
                    }
                
                TextField("Insurance",text:$insurance)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .onReceive(Just(insurance)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.insurance = filtered
                        }
                    }
                
                TextField("Taxes",text:$taxes)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .onReceive(Just(taxes)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.taxes = filtered
                        }
                    }
                //}
                
                
                
                
                Button(action: {
                    guard !name.isEmpty, !name.isEmpty else {
                        return
                    }
                    let tmpProp = Property(
                        id: "",
                        name: name,
                        image: "",
                        units: Int(units) ?? 0,
                        owned: purchaseDate,
                        address: address,
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
                            self.rootPresentationMode.wrappedValue.dismiss()
                        }
                    }
                }, label: {
                    Text("Submit")
                        .foregroundColor(.white)
                        .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                        .clipShape(Capsule())
                })
                
                
                Spacer()
            }
            .navigationTitle("Add Property")
            
            
        }
    }
}

/*
struct fieldsView: View {
    @State private var isActive : Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State var name: String = ""
    @State var address: String = ""
    @State var purchaseDate: String = ""
    @State var units: String = ""
    @State var Mortgage: String = ""
    @State var insurance: String = ""
    @State var taxes: String = ""
    @State private var emailFieldIsFocused: Bool = false
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        
        VStack{
          //  Group{
                //Text("Name")
                TextField("Name",text:$name)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                
                TextField("Address",text:$address)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                TextField("Purchase Date",text:$purchaseDate)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                TextField("Unit",text:$units)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .onReceive(Just(units)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.units = filtered
                        }
                    }
                
                TextField("Mortgage",text:$Mortgage)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .onReceive(Just(Mortgage)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.Mortgage = filtered
                        }
                    }
                
                TextField("Insurance",text:$insurance)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .onReceive(Just(insurance)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.insurance = filtered
                        }
                    }
                
                TextField("Taxes",text:$taxes)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .onReceive(Just(taxes)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.taxes = filtered
                        }
                    }
            
            Button(action: {
                guard !name.isEmpty, !name.isEmpty else {
                    return
                }
                let tmpProp = Property(
                    id: "",
                    name: name,
                    image: "",
                    units: Int(units) ?? 0,
                    owned: purchaseDate,
                    address: address,
                    expense: 0,
                    income: 0,
                    cashflow: 0,
                    taxes: Int(taxes) ?? 0,
                    insurance: Int(insurance) ?? 0
                )
                addProperty(property: tmpProp)
                self.rootPresentationMode.wrappedValue.dismiss()
                DispatchQueue.main.async {
                    // presentation.wrappedValue.dismiss()
                    
                }
            }, label: {
                Text("Add")
                    .foregroundColor(.white)
                    .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                    .clipShape(Capsule())
            })
            Spacer()
            Text("test")
            
            
            
        }

    }
    
}*/

struct AddPropertyView_Previews: PreviewProvider {
    static var previews: some View {
       AddPropertyView()
    }
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
