//
//  CustomButton.swift
//  SwAg
//
//  Created by Wonhyuk Choi on 2022/04/28.
//

import SwiftUI

struct CustomButton: View {
    var action: () -> Void
    let systemName: String
    let backgroudColor: Color
    let width: CGFloat? = nil
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 35,
                       maxHeight: 35)
                .padding()
                .foregroundColor(.black)
                .background(backgroudColor)
                .cornerRadius(6.0)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {}, systemName: "arrowtriangle.right.fill", backgroudColor: Color(red: 0.176, green: 0.608, blue: 0.94))
    }
}
