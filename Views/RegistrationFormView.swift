//
//  RegistrationFormView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/18/24.
//

import SwiftUI
import Firebase

struct RegistrationFormView: View {
    let jobTitleLabel: String
    let firstNameLabel: String
    let lastNameLabel: String
    let emailLabel: String
    let emailConfirmationLabel: String
    let passWordLabel : String
    let passWordConfirmationLabel : String
    let companyList = ["Select Organization", "Company 1", "Company 2", "Company 3", "Company 4", "Company 5"]

    
    @State var firstNameFormValue = ""
    @State var lastNameFormValue = ""
    @State var emailFormValue: String = ""
    @State var emailConfirmationFormValue = ""
    @State var jobTitleFormValue = ""
    @State var passWordFormValue: String = ""
    @State var passwordConfirmationFormValue = ""
    @State var dropDownSelectionPlaceholder = "Select Organization"
    @State var logginSuccessful = false
    
    var fireStoreAuthService: FireStoreAuthService = FireStoreAuthService()
    
    
    
    var body: some View {
        Form {
            List{
                LabelAndTextField(label: firstNameLabel, placeHolder: firstNameLabel, value: $firstNameFormValue).padding(.bottom, 20)
                LabelAndTextField(label: lastNameLabel, placeHolder: lastNameLabel, value: $lastNameFormValue).padding(.bottom, 20)
                LabelAndTextField(label: emailLabel, placeHolder: emailLabel, value: $emailFormValue).padding(.bottom, 20)
                LabelAndTextField(label: emailConfirmationLabel, placeHolder: emailConfirmationLabel, value: $emailConfirmationFormValue).padding(.bottom, 20)
                LabelAndTextField(label: jobTitleLabel, placeHolder: jobTitleLabel, value: $jobTitleFormValue).padding(.bottom, 20)
                DropdownView(selection: dropDownSelectionPlaceholder, selectionList: companyList)
                LabelAndTextField(label: passWordLabel, placeHolder: passWordLabel, value: $passWordFormValue).padding(.bottom, 20)
                LabelAndTextField(label: passWordConfirmationLabel, placeHolder: passWordConfirmationLabel, value: $passwordConfirmationFormValue).padding(.bottom, 20)
                
            }
            

            Button(action:  {
                // Login Logic Here
                fireStoreAuthService.createUser(email: emailFormValue, password: passWordFormValue)
            }, label: {
                FormButtonView(buttonLabel: "Register Account")
            }).background(
                NavigationLink(destination: HomeTabView(),
                               isActive: $logginSuccessful,
                               label: {EmptyView()}).hidden()
            )
                   
        }
    }
    
}

#Preview {
    RegistrationFormView(jobTitleLabel: "Job Title", firstNameLabel: "First Name", lastNameLabel: "Last Name", emailLabel: "Email Address", emailConfirmationLabel: "Email Confirmation", passWordLabel: "Password", passWordConfirmationLabel: "Password confirmation",firstNameFormValue: "", lastNameFormValue: "",  emailFormValue: "", emailConfirmationFormValue: "", jobTitleFormValue: "", passWordFormValue: "", passwordConfirmationFormValue: "")
}


