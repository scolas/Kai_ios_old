//
//  DatabaseManager.swift
//  Reps
//
//  Created by Scott Colas on 3/28/21.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager{
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    //video 5 5:20
    public func findUser(with email: String, completion: @escaping (User?) -> Void){
        let ref = database.collection("users")
        //video 5 sign in and up 11:14
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }),
                  error == nil else {
                completion(nil)
                return
            }
           //get first user where email are the same
            let user = users.first(where: {$0.email == email})
            completion(user)
        }
    }
    
    public func createUser(newUser: User, completion: @escaping(Bool) -> Void){
        //database documents takes dictionaries/ so we use codable and encodeable to ture our modles/struct to dictionaries
        let reference = database.document("users/\(newUser.username)")
        guard  let data = newUser.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { (error) in
            completion(error == nil)
        }
    }
    
    
    /// Create new property
    /// - Parameters:
    ///   - newPost: New Post model
    ///   - completion: Result callback
    public func createProperty(newProperty: Property, completion: @escaping (Bool) -> Void) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            completion(false)
            return
        }

        let reference = database.document("properties/\(username)/Property/\(newProperty.id)")
        guard let data = newProperty.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
    
    /// Create new Apartment
    /// - Parameters:
    ///   - newPost: New Post model
    ///   - completion: Result callback
    public func createApartment(newApartment: Apartment, completion: @escaping (Bool) -> Void) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            completion(false)
            return
        }
        //apartment/property/apartmentIds/

       // let reference = database.document("apartments/\(username)/\(newApartment.propertyId))/\(newApartment.id)")
        let reference = database.document("apartments/\(newApartment.property.id)/\(newApartment.apartmentId)/apartment")
        guard let data = newApartment.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
    
    
    /// Create new Tenant
    /// - Parameters:
    ///   - newPost: New Post model
    ///   - completion: Result callback
    public func createTenant(newTenant: Tenant, completion: @escaping (Bool) -> Void) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            completion(false)
            return
        }

        let reference = database.document("Tenants/\(username)/Tenant/\(newTenant.id)")
        guard let data = newTenant.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
    
    /// Get a property with id and username
    /// - Parameters:
    ///   - identifer: Query id
    ///   - username: Query username
    ///   - completion: Result callback
    public func getProperty(
        with identifer: String,
        from username: String,
        completion: @escaping (Property?) -> Void
    ) {
        let ref = database.collection("properties")
            .document(username)
            .collection("Property")
            .document(identifer)
        ref.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  error == nil else {
                completion(nil)
                return
            }

            completion(Property(with: data))
        }
    }
    
    

    
    
    /// Find properties  from a given user
    /// - Parameters:
    ///   - username: Username to query
    ///   - completion: Result callback
    public func properties(
        for username: String,
        completion: @escaping (Result<[Property], Error>) -> Void
    ) {
        let ref = database.collection("properties")
            .document(username)
            .collection("Property")
        ref.getDocuments { snapshot, error in
            guard let properties = snapshot?.documents.compactMap({
                Property(with: $0.data())
            }),
            error == nil else {
                return
            }
            completion(.success(properties))
        }
    }
    
    
    /// Find tenants  from a given user
    /// - Parameters:
    ///   - username: Username to query
    ///   - completion: Result callback
    public func tenants(
        for username: String,
        completion: @escaping (Result<[Tenant], Error>) -> Void
    ) {
        let ref = database.collection("Tenants")
            .document(username)
            .collection("Tenant")
        ref.getDocuments { snapshot, error in
            guard let tenants = snapshot?.documents.compactMap({
                Tenant(with: $0.data())
            }),
            error == nil else {
                return
            }
            completion(.success(tenants))
        }
    }
    
    
    /// Create new property
    /// - Parameters:
    ///   - newPost: New Post model
    ///   - completion: Result callback
    public func addUserRole(newUser: User, completion: @escaping (Bool) -> Void) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            completion(false)
            return
        }

        let reference = database.document("Roles/\(username)/")
        guard let data = newUser.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
    
    
    public func addUserRole1(newUser: User) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
           // completion(false)
            return
        }

        let reference = database.document("Roles/\(username)/")
        guard let data = newUser.asDictionary() else {
            //completion(false)
            return
        }
        reference.setData(data) { error in
           // completion(error == nil)
        }
    }
    
    /// Get a property with id and username
    /// - Parameters:
    ///   - identifer: Query id
    ///   - username: Query username
    ///   - completion: Result callback
    public func getUser(
        for username: String
    ) {
        let ref = database.collection("Roles")
            .document(username)
        ref.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  error == nil else {
             
                return
            }

            
        }
    }
    
    public func getUser2(
        for username: String,
        completion: @escaping (Int) -> Void
    ) {
        let ref = database.collection("Roles")
            .document(username)
        ref.getDocument { snapshot, error in
            guard let roles = snapshot?.data(),
                  error == nil else {
                completion(-1)
                return
            }
            //get user role
            let role = roles["role"]
            let rolenum: Int? = Int(role as! String)
            completion(rolenum ?? -1)
        }
    }
    public func getUserRole(for username: String, completion: @escaping (_ result: Int) -> ()){
        let result = 1
        let ref = database.collection("Roles")
            .document(username)
        ref.getDocument { snapshot, error in
            guard let roles = snapshot?.data(),
            error == nil else {
                return
            }
            //completion(result)
            completion(UserRole(with: roles)?.userRole ?? -1)
        }
    }
   /*
    if userrole > 0 {
        
        rolein = userrole
        Completion(1)
    }else{
        Completion(-1)
    }
    
    
    //video 5 5:20
    public func findUser(with email: String, completion: @escaping (User?) -> Void){
        let ref = database.collection("users")
        //video 5 sign in and up 11:14
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }),
                  error == nil else {
                completion(nil)
                return
            }
           //get first user where email are the same
            let user = users.first(where: {$0.email == email})
            completion(user)
        }
    }*/

}
