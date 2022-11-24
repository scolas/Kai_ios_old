//
//  SignUpView.swift
//  Kai
//
//  Created by Scott Colas on 2/11/22.
//

import SwiftUI

struct SignUpView: View {
    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var emailFieldIsFocused: Bool = false
    
    var body: some View {
        VStack{
            Text("Username")
            TextField("Username",text:$username)
            Text("Email")
            TextField("Email",text:$username)
            Text("Password")
            SecureField("password",text:$password)
   
            Button("Sign Up") {
                print("Button pressed!")
            }
            .padding()
            .foregroundColor(.white)
            .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color(red: 0.063, green: 0.376, blue: 0.282))
            .clipShape(Capsule())
            
            Text("Dont have an account?")
            Text("Register Now")
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
