//
//  InfoPointView.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import SwiftUI

struct InfoPointView: View {
    
    @Environment(\.dismiss) var dismiss
    var order: Order
    @State var active = false
    @State var title = ""
    @State var descript = ""
    @Binding var needRefresh: Bool
    @State var readWrite = false
    @State var type = ""
    @State var vitNad = "Витрата"
    var categ: [String]
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            return formatter
        }()
    
    var body: some View {
        ZStack{
            VStack {
                
                Text("Made in: \(dateFormatter.string(from: order.time!))")
                    .opacity(0.6)
                    .font(.subheadline)
                    .padding(5)
                    .background()
                    .cornerRadius(3)
                
                if readWrite {
                    NeumorphicStyleTextField(text: order.title ?? "Title...", inputText: $title)
                        .padding()
                    
                    HStack {
                        Picker(order.type!, selection: $type) {
                            ForEach(categ, id: \.self) {
                                Text($0)
                            }
                        }.frame(maxWidth: 300)
                            .background()
                            .cornerRadius(12)
                    }
                    CustomTextEditor(text: $descript, placeholder: "Change text...")
                        .padding()
                    
                    HStack {
                        Button {
                            if descript != ""{
                                order.descript = descript
                            }
                            
                            if title != ""{
                                order.title = title
                            }
                            
                            if type != "" {
                                order.type = type
                            }
                            
                            CoreDataService.shared.updatePoint()
                            needRefresh.toggle()
                            dismiss()
                        } label: {
                            CustomButton(title: "Save")
                        }
                        Button {
                            readWrite.toggle()
                        } label: {
                            CustomButton(title: "Read")
                        }
                    }
                } else {
                    HStack {
                        Text(order.type ?? "Усі").padding()
                            .frame(maxWidth: .infinity)
                            .background()
                            .cornerRadius(12)
                            .padding()
                            .foregroundColor(Color(.label).opacity(0.75))
                        
                        Text(order.vitNad!).padding()
                            .frame(maxWidth: .infinity)
                            .background()
                            .cornerRadius(12)
                            .padding()
                            .foregroundColor(Color(.label).opacity(0.75))
                    }
                    Text(order.title ?? "")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(12)
                        .padding()
                        .foregroundColor(Color(.label).opacity(0.75))
                    
                    Text(order.descript ?? "")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(12)
                        .padding()
                        .foregroundColor(Color(.label).opacity(0.75))
                    
                    Button {
                        readWrite.toggle()
                    } label: {
                        CustomButton(title: "Change")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.indigo)
            
            VStack{
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Text("\(Image(systemName: "arrow.backward")) Назад")
                            .padding(.leading, 10)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                Spacer()
            }
            
        }
    }
}

struct InfoPointView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPointView(order: Order.example, needRefresh: .constant(false), categ: ["Усі", "Продукти", "Комуналка", "Ремонт", "Розваги", "Подорожі", "Інше"])
    }
}





