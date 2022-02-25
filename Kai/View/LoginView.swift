//
//  LoginView.swift
//  Kai
//
//  Created by Scott Colas on 2/8/22.
//

import SwiftUI
import FirebaseAuth
class AppViewModel: ObservableObject{
    let auth = Auth.auth()
    // updates becuse its binding/live data
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
}

struct LoginView: View {
   
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
       /* NavigationView{
            if viewModel.signedIn{
                PortfolioView()
            }else{
                LoginSubView(vm: viewModel)
            }
        }.onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }*/
        PortfolioView()
    }

}

struct LoginSubView: View {
    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State var username: String = ""
    @State var password: String = ""
    //@EnvironmentObject var viewModel: AppViewModel
    var vm: AppViewModel
    @State private var emailFieldIsFocused: Bool = false

    var body: some View {
        
        VStack{
            Text("Email")
            TextField("Email",text:$username)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            Text("Password")
                .padding()
            SecureField("password",text:$password)
                .padding()
            
            Text("Forgot your password")
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            Button("Log In") {
                print("Button pressed!")
            }
            .padding()
            .foregroundColor(.white)
            .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color(red: 0.063, green: 0.376, blue: 0.282))
            .clipShape(Capsule())
            
            Button(action: {
                guard !username.isEmpty, !password.isEmpty else {
                    return
                }
                vm.signIn(email: username, password: password)
            }, label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                    .clipShape(Capsule())
            })
            NavigationLink("Create Account22", destination: signUpSubView(vm: vm))
            
            Text("Dont have an account?")
            Text("Register Now")
        }

    }
    
    
}

struct signUpSubView: View {
    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State var username: String = ""
    @State var password: String = ""
    //@EnvironmentObject var viewModel: AppViewModel
    var vm: AppViewModel
    @State private var emailFieldIsFocused: Bool = false

    var body: some View {
        
        VStack{
            Text("Email")
            TextField("Email",text:$username)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            Text("Password")
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            SecureField("password",text:$password)
                .padding()
      
            Button(action: {
                guard !username.isEmpty, !password.isEmpty else {
                    return
                }
                vm.signUp(email: username, password: password)
            }, label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                    .clipShape(Capsule())
            })
            .padding()
            
        }
        .navigationTitle("Create Account")

    }
    
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
