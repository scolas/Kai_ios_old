//
//  AuthManager.swift
//  Reps
//
//  Created by Scott Colas on 3/28/21.
//

import FirebaseAuth
import Foundation

/// Object to manage authentication
final class AuthManager: ObservableObject {
    /// Shared instanece
    static let shared = AuthManager()

    /// Private constructor
     init() {}

    /// Auth reference
     let auth = Auth.auth()

    /// Auth errors that can occur
    enum AuthError: Error {
        case newUserCreation
        case signInFailed
    }

    /// Determine if user is signed in
   /*
    var isSignedIn = false
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }*/
    
    @Published var signedIn = false
    @Published var accountNum = -1
    var accountType = Role.tenant
    
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
                //self?.signedIn = true
                UserDefaults.standard.setValue(email, forKey: "username")
                UserDefaults.standard.setValue(email, forKey: "email")
                self?.signedIn = true
                
                //accountType = result["role"]
                //var test = ""
            }
            
        }
    }
    /// Attempt sign in
    /// - Parameters:
    ///   - email: Email of user
    ///   - password: Password of user
    ///   - completion: Callback
   /* public func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        DatabaseManager.shared.findUser(with: email) { [weak self] user in
            guard let user = user else {
                completion(.failure(AuthError.signInFailed))
                return
            }

            self?.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                }

                UserDefaults.standard.setValue(user.username, forKey: "username")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                completion(.success(user))
            }
        }
    }*/

    /// Attempt new user sign up
    /// - Parameters:
    ///   - email: Email
    ///   - username: Username
    ///   - password: Password
    ///   - profilePicture: Optional profile picture data
    ///   - completion: Callback
   /* public func signUp(
        email: String,
        username: String,
        password: String,
       // profilePicture: Data?,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        let newUser = User(username: username, email: email, userRole: 2)
        // Create account
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(.failure(AuthError.newUserCreation))
                return
            }

            DatabaseManager.shared.createUser(newUser: newUser) { success in
                if success {
                   /* StorageManager.shared.uploadProfilePicture(
                        username: username
                        //data: profilePicture
                    ) { uploadSuccess in
                        if uploadSuccess {
                            completion(.success(newUser))
                        }
                        else {
                            completion(.failure(AuthError.newUserCreation))
                        }
                    }*/
                    completion(.success(newUser))
                }
                else {
                    completion(.failure(AuthError.newUserCreation))
                }
            }
        }
    }*/
    
    func signUp(email: String, password: String,completion: @escaping (Result<User, Error>) -> Void){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
                UserDefaults.standard.setValue(email, forKey: "username")
                UserDefaults.standard.setValue(email, forKey: "email")
                let newUser = User.init(username: email, email: email, userRole: 3)
                DatabaseManager.shared.addUserRole1(newUser: newUser)
                //completion(.success(newUser))
            }
           /* var newUser = User.init(username: email, email: email, userRole: 3)
            DatabaseManager.shared.addUserRole(newUser: newUser){ success in
                if success {
                    completion(.success(newUser))
                   
                }
                else {
                    //completion(.failure(AuthError.newUserCreation))
                }
            }
            */
        }
    }

    
    func signOut(){
        
        try? auth.signOut()
        UserDefaults.standard.setValue("", forKey: "username")
        UserDefaults.standard.setValue("", forKey: "email")
        self.signedIn = false
    }
    
    public func getUserRoleAuth(){
        var username = UserDefaults.standard.string(forKey: "username") ?? " "
        DatabaseManager.shared.getUserRole(for: username) { result in
            
        }
    }
    
    /// Attempt Sign Out
    /// - Parameter completion: Callback upon sign out
    /*public func signOut(
        completion: @escaping (Bool) -> Void
    ) {
        do {
            try auth.signOut()
            completion(true)
        }
        catch {
            print(error)
            completion(false)
        }
    }*/
}
