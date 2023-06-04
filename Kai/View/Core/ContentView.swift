//
//  LoginView.swift
//  Kai
//
//  Created by Scott Colas on 2/8/22.
//
import SafariServices
import UIKit
import SwiftUI
import FirebaseAuth
class AppViewModel: ObservableObject{
    let auth = Auth.auth()
    
    @Published var signedIn_ = false
    
    var isSignedIn_: Bool{
        return auth.currentUser != nil
    }
    
    func getUserRoleVal(){
        var username = UserDefaults.standard.string(forKey: "username") ?? " "
        //var userdata = DatabaseManager.shared.getUser(for:username)
       /* var rolein = -1
        var rolein1 = DatabaseManager.shared.getUser2(for:"mrcolas") { userroleVal in
                if userroleVal == -1 {
                   // Completion(.success(userroleVal))
                   var w = 1
                }
                else {
                    //completion(.failure(AuthError.newUserCreation))
                    var w = userroleVal
                }
            }*/
        
        DatabaseManager.shared.getUserRole(for:username) { result in
            
        }
    }
    
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                //self?.signedIn = true
            }
            
            
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                //self?.signedIn = true
            }
            var newUser = User.init(username: email, email: email, userRole: 3)
            DatabaseManager.shared.addUserRole(newUser: newUser){ sucess in
                if sucess {
                    completion(.success(newUser))
                }
                else {
                    //completion(.failure(AuthError.newUserCreation))
                }
            }
       
        
            
        }
    }
    
    func signOut(){
        try? auth.signOut()
        
        //self.signedIn = false
    }

    
}

struct ContentView: View {
   // @State var username = ""
   // @State var password = ""
    //@EnvironmentObject var viewModel: AppViewModel
    //var vm: AppViewModel
   // @State private var emailFieldIsFocused: Bool = false

    //@EnvironmentObject var viewModel: AppViewModel

    @EnvironmentObject var viewModelAuth: AuthManager
    var username = UserDefaults.standard.string(forKey: "username") ?? " "
    //var userdata = DatabaseManager.shared.getUser(for:username)
    var rolein = -1
    
 

        //rolein = userrole
    
    var body: some View {

        NavigationView{
           // if viewModel.signedIn{
            //if AuthManager.shared.isSignedIn{
            
            if viewModelAuth.signedIn{
              
      
                VStack{
                    //if viewModelAuth.accountType == Role.tenant{
                    if viewModelAuth.accountNum == 2{
                            TabBarTenantView()
               
                    }
                   // else if viewModelAuth.accountType == Role.owner{
                    else if viewModelAuth.accountNum == 3{
                        TabBarOwnerView()
                    }else{
                    
                            TabBarTenantView()
                     
                    }
                    /*Text("you are signed in")
                    Button(action: {
                        //viewModel.signOut()
                        viewModelAuth.signOut()
                    }, label: {
                        Text("Sign out")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .padding()
                    })*/
                }
            }
            else{
                LoginSubView()
                
               /* let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
            
                    
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
                            viewModel.signIn(email: username, password: password)
                        }, label: {
                            Text("Sign In")
                                .foregroundColor(.white)
                                .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                                .clipShape(Capsule())
                        })
                        NavigationLink("Create Account", destination: signUpSubView().environmentObject(self.viewModel))
                        
                        Text("Dont have an account?")
                        Text("Register Now")
                    }*/
                //SignInView()
                //Text("Signout view")
                    
                }
            
        }
        .onAppear{
            viewModelAuth.signedIn = viewModelAuth.isSignedIn
            DispatchQueue.main.async {
                DatabaseManager.shared.getUserRole(for: username) { result in
                    print(result)
                    viewModelAuth.accountNum = result
                }
            }

           // viewModel.signedIn = viewModel.isSignedIn
           // AuthManager.shared.isSignedIn =
        }
        //LoginSubView(vm: viewModel)
        //LoginSubView()
        
    }

}

struct LoginSubView: View {
    //var vm: AppViewModel

    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State var username: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModelAuth: AuthManager
    //var vm: AppViewModel
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
            
            Button(action: {
                guard !username.isEmpty, !password.isEmpty else {
                    return
                }
                //viewModel.signIn(email: username, password: password)
                viewModelAuth.signIn(email: username, password: password)
                
                /*AuthManager.shared.signIn(email: username, password: password) {  result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
                           // HapticsManager.shared.vibrate(for: .success)
                            //self?.dismiss(animated: true, completion: nil)
                           Text("Logged in")
                        case .failure:
                           // HapticsManager.shared.vibrate(for: .error)
                            let alert = UIAlertController(
                                title: "Sign In Failed",
                                message: "Please check your email and password to try again.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                           // self?.present(alert, animated: true)
                            //self?.passwordField.text = nil
                        }
                    }
                }*/
            }, label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                    .clipShape(Capsule())
            })
            NavigationLink("Create Account", destination: signUpSubView())
            Text("Dont have an account?")
            Text("Register Now")
        }
        
    }
    
    
}

struct signUpSubView: View {
    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State var username: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModelAuth: AuthManager
 
  
    //var vm: AppViewModel
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
                //vm.signUp(email: username, password: password)
                viewModelAuth.signUp(email: username, password: password){ success in
                
                    var newUser = User.init(username: username, email: username, userRole: 2)
                    DatabaseManager.shared.addUserRole(newUser: newUser){ success in
                        if success {
                            //completion(.success(newUser))
                           var w = 1
                        }
                        else {
                            //completion(.failure(AuthError.newUserCreation))
                            var w = 2
                        }
                    }
                }
                
                /*AuthManager.shared. bsignUp(email: username, username: "",email, username: username, password: password) { success in
                    DispatchQueue.main.async {
                        if success {
                            HapticsManager.shared.vibrate(for: .success)
                            self?.dismiss(animated: true, completion: nil)
                        } else {
                            HapticsManager.shared.vibrate(for: .error)
                            let alert = UIAlertController(
                                title: "Sign Up Failed",
                                message: "Something went wrong when trying to register. Pleaes try again.",
                                preferredStyle: .alert
                            )
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                            self?.present(alert, animated: true)
                        }
                    }
                }*/
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
        ContentView()
    }
}
