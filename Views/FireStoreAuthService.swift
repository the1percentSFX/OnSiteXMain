//
//  FireStoreAuthService.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/27/24.
//

import Foundation

import Firebase


class FireStoreAuthService {
    func createUser(email: String, password: String){
        if !email.isEmpty && !password.isEmpty {
            Auth.auth().createUser(withEmail: email, password: password) { AuthDataResult, error in
                if let e = error {
                    print(e)
                }
            }
        } else {
            print("Location=FireStoreAuthService.createUser() status=ERROR message: User not created! password or email empty")
        }
    }
    
    func logInUser(email: String, password: String){
        if !email.isEmpty && !password.isEmpty {
            Auth.auth().signIn(withEmail: email, password: password) { AuthDataResult, error in
                if let e = error {
                    print(e)
                } else {
                    print("status=INFO message: user " + email +  " logged in successfully! ")
                }
            }
        } else {
            print("Location=FireStoreAuthService.createUser() status=ERROR message: User not created! password or email empty")
        }
    }
    
}
