//
//  tempSetTenant.swift
//  Kai
//
//  Created by Scott Colas on 12/25/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct TenantToApartment{
    let TenantEmail: String
    let unitNum: String
    let PropertyId: String
}

struct FormView: View {
    // State variables for the email text field and dropdown pickers
    @State private var TenantEmailTxt: String = ""
    @State private var picker1Selection: String = ""
    @State private var picker2Selection: String = ""
    
    // Array to populate the first dropdown picker
    let picker1Options = ["Option 1", "Option 2", "Option 3"]
    
    // Array to hold the options for the second dropdown picker
    // This will be populated from data fetched from Firebase
    @State private var picker2Options: [String] = []
    // State variable to indicate whether the data from Firebase has been fetched
     @State private var dataFetched: Bool = false
    
    // Database reference for fetching data from Firebase
    let db = Firestore.firestore()
    var body: some View {
        if dataFetched == true{
            Form {
                // Email text field
                TextField("Email", text: $TenantEmailTxt)
                
                // First dropdown picker
                Picker("Picker 1", selection: $picker1Selection) {
                    ForEach(picker1Options, id: \.self) { option in
                        Text(option)
                    }
                }.pickerStyle(MenuPickerStyle())
          
                // Second dropdown picker
                Picker("Picker 2", selection: $picker2Selection) {
                    ForEach(picker2Options, id: \.self) { option in
                        Text(option)
                    }
                }.pickerStyle(MenuPickerStyle())
                
                // Submit button
                Button(action: {
                    // Store the form data in the Firebase database
                    self.storeDataInFirebase()
                }) {
                    Text("Submit")
                }
            }
        }
            else{
                Text("Loading...")  .onAppear {
                    // Fetch the data for the second dropdown picker when the form appears
                    self.fetchDataFromFirebase()
                }
            }
        }
   
    
    


    struct FormView_Previews: PreviewProvider {
        static var previews: some View {
            FormView()
        }
    }
    
    func storeDataInFirebase() {
        // Create a dictionary with the form data
        let data: [String: Any] = [            "email": TenantEmailTxt,            "picker1Selection": picker1Selection,            "picker2Selection": picker2Selection        ]
        //let reference = db.document("TenantApartmentId/\(email)")
        //reference.setData(data) 
        // Add the data to the Firebase database
        db.collection("TenantApartmentId/\(TenantEmailTxt)/Ids").addDocument(data: data) { (error) in
            if let error = error {
                print("Error storing data in Firebase: \(error)")
            } else {
                print("Successfully stored data in Firebase")
            }
        }
    }
    
    func fetchDataFromFirebase() {
        let username = UserDefaults.standard.string(forKey: "email") ?? ""
        // Fetch the data for the second dropdown picker from the Firebase database
      //  db.collection("picker2Options").getDocuments
        db.collection("properties").document(username).collection("Property").getDocuments()   { (querySnapshot, error) in
            if let error = error {
                print("Error fetching data from Firebase: \(error)")
            } else {
                // Clear the array of picker options
                self.picker2Options.removeAll()
                
                // Iterate through the documents in the query snapshot
                for document in querySnapshot!.documents {
                              //let option = document.data()["option"] as! String
                           //   self.picker2Options.append(option)
                }
                
                
                guard let properties = querySnapshot?.documents.compactMap({
                    Property(with: $0.data())
                }),
                error == nil else {
                    return
                }
                
                for building in properties{
                    self.picker2Options.append(building.name)
                    self.dataFetched = true
                }
                /*for document in querySnapshot!.documents {
                              let option = document.data()["option"] as! String
                              self.picker2Options.append(option)
                }
                let ref = db.collection("properties")
                    .document(username)
                    .collection("Property")
                ref.getDocuments { snapshot, error in
                    guard let properties = querySnapshot?.documents.compactMap({
                        Property(with: $0.data())
                    }),
                    error == nil else {
                        return
                    }*/
            }
        }
    }
}
