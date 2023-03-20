//
//  CustomTextEditor.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    var placeholder: String
    @State private var totalChars = 0
    @State private var lastText = ""
        
    var body: some View {
        VStack {
            ZStack{
                TextEditor(text: $text)
                    .padding()
                    .scrollContentBackground(.hidden)
                    .background(.white)
                    .foregroundColor(.indigo)
                    .fontWeight(.bold)
                    .frame(height: 250)
                    .cornerRadius(6)
                    .shadow(radius: 5)
                
                if text.count == 0{
                    Text(placeholder)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .opacity(0.3)
                }
            }
            ProgressView("Chars: \(totalChars) / 250", value: Double(totalChars), total: 250)
                .frame(width: 150)
                .padding()
                .foregroundColor(.white)
                .accentColor(.green)
        }.onChange(of: text, perform: { text in
            totalChars = text.count
            
            if totalChars <= 250 {
                    lastText = text
                } else {
                    self.text = lastText
                }
        })
        
        
    }
}

struct CustomTextEditor_Previews: PreviewProvider {
    
    @State static var a = ""
    static var previews: some View {
        CustomTextEditor(text: $a, placeholder: "Text...")
    }
}
