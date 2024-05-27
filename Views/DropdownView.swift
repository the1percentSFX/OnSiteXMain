//
//  DropdownView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/27/24.
//

import SwiftUI

struct DropdownView: View {
    @State var selection: String
    let selectionList: Array<String>

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Company")
                .font(.headline)
            Picker(selection, selection: $selection) {
                ForEach(selectionList, id: \.self) {
                    Text($0).foregroundColor(.black)
                }
            }
            .foregroundColor(.black)
            .padding(.all)
            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 0.6))
            .pickerStyle(.menu)

            
        }
        .padding(.leading, 10)
        .foregroundColor(.black)
        .font(.headline)
    }
}

#Preview {
    DropdownView(selection: "Select Organization", selectionList: ["Select Organization", "Company 1", "Company 2", "Company 3", "Company 4", "Company 5"])
}
