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
    
    var body: some View {
        Form{
            TextField(emailLabel, text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField(passwordLabel, text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                // Login Logic Here
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.teal)
                    
                    Text("Login")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            
        }
    }
}

#Preview {
//    LoginFormView(emailLabel: "Email Address", passWordLabel: "Password")
    LoginFormView(emailLabel: "Email Address", passwordLabel: "Password")
}
