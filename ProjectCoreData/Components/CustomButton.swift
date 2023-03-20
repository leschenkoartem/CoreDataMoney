//
//  CustomButton.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var body: some View {
        Text(title)
            .padding()
            .foregroundColor(.black.opacity(0.75))
            .fontWeight(.bold)
            .background(.white)
            .cornerRadius(12)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Press me!")
    }
}
