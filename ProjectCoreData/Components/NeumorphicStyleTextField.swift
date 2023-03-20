//
//  CustomTextField.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import SwiftUI

struct NeumorphicStyleTextField: View {
    var text: String
    @Binding var inputText: String
    var body: some View {
        HStack {
            TextField(text, text: $inputText)
        }
        .padding()
        .foregroundColor(.indigo)
        .fontWeight(.bold)
        .background(.white)
        .cornerRadius(6)
        .shadow(radius: 5)
        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    
    @State static var a = "gevgv"
    static var previews: some View {
        NeumorphicStyleTextField(text: "Text...", inputText: $a)
    }
}


