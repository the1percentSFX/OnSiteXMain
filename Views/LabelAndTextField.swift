//
//  LabelAndTextField.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/18/24.
//

import SwiftUI


struct LabelAndTextField : View {
    @State var label: String
    @State var placeHolder: String
    @State var value: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
            TextField(placeHolder, text: $value)
                .padding(.all)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 0.6))
        }
        .padding(.leading, 10)
    }
}

#Preview {
    LabelAndTextField(label: "Label Text",  placeHolder: "Placeholder text ", value: "")
}
