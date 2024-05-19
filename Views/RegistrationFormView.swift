//
//  RegistrationFormView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/18/24.
//

import SwiftUI

struct RegistrationFormView: View {
    let jobTitleLabel: String
    let firstNameLabel: String
    let lastNameLabel: String
    let emailLabel: String
    let emailConfirmationLabel: String
    let passWordLabel : String
    let passWordConfirmationLabel : String
    
    
    @State var firstNameFormValue = ""
    @State var lastNameFormValue = ""
    @State var emailFormValue = ""
    @State var emailConfirmationFormValue = ""
    @State var jobTitleFormValue = ""
    @State var passWordFormValue = ""
    @State var passwordConfirmationFormValue = ""
    
    var body: some View {
        Form{
            List{
                LabelAndTextField(label: firstNameLabel, placeHolder: firstNameLabel, value: firstNameFormValue).padding(.bottom, 20)
                LabelAndTextField(label: lastNameLabel, placeHolder: lastNameLabel, value: lastNameFormValue).padding(.bottom, 20)
                LabelAndTextField(label: emailLabel, placeHolder: emailLabel, value: emailFormValue).padding(.bottom, 20)
                LabelAndTextField(label: emailConfirmationLabel, placeHolder: emailConfirmationLabel, value: emailConfirmationFormValue).padding(.bottom, 20)
                LabelAndTextField(label: jobTitleLabel, placeHolder: jobTitleLabel, value: jobTitleFormValue).padding(.bottom, 20)
                LabelAndTextField(label: passWordLabel, placeHolder: passWordLabel, value: passWordFormValue).padding(.bottom, 20)
                LabelAndTextField(label: passWordConfirmationLabel, placeHolder: passWordConfirmationLabel, value: passwordConfirmationFormValue).padding(.bottom, 20)
                
            }
            

            Button {
                // Login Logic Here
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.teal)
                    
                    Text("Register Account")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            
        }
    }
}

#Preview {
    RegistrationFormView(jobTitleLabel: "Job Title", firstNameLabel: "First Name", lastNameLabel: "Last Name", emailLabel: "Email Address", emailConfirmationLabel: "Email Confirmation", passWordLabel: "Password", passWordConfirmationLabel: "Password confirmation",firstNameFormValue: "", lastNameFormValue: "",  emailFormValue: "", emailConfirmationFormValue: "", jobTitleFormValue: "", passWordFormValue: "", passwordConfirmationFormValue: "")
}
