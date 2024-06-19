//
//  LoginHeaderView.swift
//  OnSiteX
//
//  Created by Tristan Shelton on 5/18/24.
//

import SwiftUI

struct LoginHeaderView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.teal)
                .rotationEffect(Angle(degrees: 15))
            
            VStack{
                Text("On Site X")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .bold()
                
            }.padding(.top, 30)
            
            
        }.frame(
            width: UIScreen.main.bounds.width * 3,
            height: 450
        ).offset(y: -180)
    }
}

#Preview {
    LoginHeaderView()
}
