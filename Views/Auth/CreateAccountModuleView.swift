//
//  CreateAccountModuleView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/18/24.
//

import SwiftUI

struct CreateAccountModuleView: View {
    let moduleLabel: String
    let navigationLinkLabel: String
    
    var body: some View {
        VStack{
            Text(moduleLabel)
            NavigationLink(navigationLinkLabel,
                           destination: RegistrationFormView(jobTitleLabel: "Job Title", firstNameLabel: "First Name", lastNameLabel: "Last Name", emailLabel: "Email Address", emailConfirmationLabel: "Email Confirmation", passWordLabel: "Password", passWordConfirmationLabel: "Password confirmation",firstNameFormValue: "", lastNameFormValue: "",  emailFormValue: "", emailConfirmationFormValue: "", jobTitleFormValue: "", passWordFormValue: "", passwordConfirmationFormValue: ""))
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }.padding(.bottom, 10)
    }
}

#Preview {
    CreateAccountModuleView(moduleLabel: "New user ?", navigationLinkLabel: "Create Account here")
}
