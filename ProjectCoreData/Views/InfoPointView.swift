//
//  InfoPointView.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import SwiftUI

struct InfoPointView: View {
    
    @Environment(\.dismiss) var dismiss
    var point: PlanPoint
    @State var active = false
    @State var title = ""
    @State var descript = ""
    @Binding var needRefresh: Bool
    @State var readWrite = false
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            return formatter
        }()
    
    var body: some View {
        ZStack{
            VStack {
                
                Text("Made in: \(dateFormatter.string(from: point.time!))")
                    .opacity(0.6)
                    .font(.subheadline)
                    .padding(5)
                    .background()
                    .cornerRadius(3)
                
                if readWrite {
                    NeumorphicStyleTextField(text: point.title ?? "Title...", inputText: $title)
                        .padding()
                    
                    CustomTextEditor(text: $descript, placeholder: "Change text...")
                        .padding()
                    
                    HStack {
                        Button {
                            if descript != ""{
                                point.descript = descript
                            }
                            if title != ""{
                                point.title = title
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
                    Text(point.title ?? "")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(12)
                        .padding()
                        .foregroundColor(Color(.label).opacity(0.75))
                    
                    Text(point.descript ?? "")
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
        InfoPointView(point: PlanPoint.example, needRefresh: .constant(false))
    }
}





