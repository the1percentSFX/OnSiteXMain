//
//  LoginView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/18/24.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    
    var body: some View {
        NavigationView{
            VStack{
                // Header Region
                LoginHeaderView()
                
                
                // Login Form
                LoginFormView(emailLabel: "Email Address", passwordLabel: "Password")
                
                // Create Account
                CreateAccountModuleView(moduleLabel: "New user ?", navigationLinkLabel: "Create Account here")
                
                Spacer()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    LoginView()
}






