//
//  RegisterButtonView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/27/24.
//

import SwiftUI

struct FormButtonView: View {
    let buttonLabel: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.teal)
            
            Text(buttonLabel)
                .foregroundColor(.white)
                .bold()
        }
    }
}

#Preview {
    FormButtonView(buttonLabel: "Register Account")
}
