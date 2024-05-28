//
//  LoginFormView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/18/24.
//

import SwiftUI

struct LoginFormView: View {
    let emailLabel: String
    let passwordLabel: String
    
    @State var email = ""
    @State var password = ""
    @State var navigateToHome = true
    
    var fireStoreAuthService: FireStoreAuthService = FireStoreAuthService()
    
    var body: some View {
        Form{
            TextField(emailLabel, text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField(passwordLabel, text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                // Login Logic Here
                fireStoreAuthService.logInUser(email: email, password: password)
            }, label: {
                FormButtonView(buttonLabel: "Login")
            }).background(
                NavigationLink(destination: HomeTabView(),
                               isActive: $navigateToHome,
                               label: {EmptyView()}).hidden()
            )
            
        }
    }
}

#Preview {
//    LoginFormView(emailLabel: "Email Address", passWordLabel: "Password")
    LoginFormView(emailLabel: "Email Address", passwordLabel: "Password")
}



